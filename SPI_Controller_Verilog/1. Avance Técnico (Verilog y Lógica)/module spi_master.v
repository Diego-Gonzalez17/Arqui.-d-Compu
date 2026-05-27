module spi_master(
    input wire clk,          // Reloj del sistema
    input wire rst,          // Reset
    input wire start,        // Señal para iniciar transmisión
    input wire [7:0] data_in,// Dato a enviar
    output reg [7:0] data_out,// Dato recibido
    output reg sclk,         // Serial Clock
    output reg mosi,         // Master Out Slave In
    input wire miso,         // Master In Slave Out
    output reg ss,           // Slave Select
    output reg done          // Señal de transmisión completa
);

// Estados de la FSM
parameter IDLE = 2'b00;
parameter SETUP = 2'b01;
parameter TRANSMIT = 2'b10;
parameter DONE = 2'b11;

reg [1:0] state;
reg [2:0] bit_counter;
reg [7:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        ss <= 1;
        sclk <= 0;
        done <= 0;
    end
    else begin
        case(state)
            IDLE: begin
                ss <= 1;
                done <= 0;
                if(start)
                    state <= SETUP;
            end

            SETUP: begin
                ss <= 0;
                shift_reg <= data_in;
                bit_counter <= 3'd7;
                state <= TRANSMIT;
            end

            TRANSMIT: begin
                sclk <= ~sclk;
                if (sclk == 0) begin
                    mosi <= shift_reg[bit_counter];
                    data_out[bit_counter] <= miso;
                    if(bit_counter == 0)
                        state <= DONE;
                    else
                        bit_counter <= bit_counter - 1;
                end
            end

            DONE: begin
                ss <= 1;
                done <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule