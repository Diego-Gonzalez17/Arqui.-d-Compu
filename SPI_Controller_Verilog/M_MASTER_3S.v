module M_MASTER #(
    parameter CLK_DIV = 4
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       start,
    input  wire [1:0] slave_sel,
    input  wire [7:0] tx_data,
    input  wire       miso,
    output reg        mosi,
    output reg        sclk,
    output reg        ss1,
    output reg        ss2,
    output reg        ss3,
    output reg [7:0]  rx_data,
    output reg        busy,
    output reg        done
);

    reg [1:0]  state;
    reg [7:0]  shift_tx;
    reg [7:0]  shift_rx;
    reg [2:0]  bit_count;
    reg [15:0] clk_count;

    localparam IDLE     = 2'b00;
    localparam SETUP    = 2'b01;
    localparam TRANSFER = 2'b10;
    localparam DONE_ST  = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            shift_tx  <= 8'b0;
            shift_rx  <= 8'b0;
            bit_count <= 3'b0;
            clk_count <= 16'b0;
            mosi      <= 1'b0;
            sclk      <= 1'b0;
            ss1       <= 1'b1;
            ss2       <= 1'b1;
            ss3       <= 1'b1;
            rx_data   <= 8'b0;
            busy      <= 1'b0;
            done      <= 1'b0;
        end else begin
            done <= 1'b0;

            case (state)
                IDLE: begin
                    ss1       <= 1'b1;
                    ss2       <= 1'b1;
                    ss3       <= 1'b1;
                    sclk      <= 1'b0;
                    busy      <= 1'b0;
                    clk_count <= 16'b0;

                    if (start) begin
                        if (slave_sel == 2'b00) begin
                            shift_tx  <= tx_data;
                            shift_rx  <= 8'b0;
                            bit_count <= 3'b0;
                            mosi      <= tx_data[7];
                            ss1       <= 1'b0;
                            ss2       <= 1'b1;
                            ss3       <= 1'b1;
                            busy      <= 1'b1;
                            state     <= SETUP;
                        end else if (slave_sel == 2'b01) begin
                            shift_tx  <= tx_data;
                            shift_rx  <= 8'b0;
                            bit_count <= 3'b0;
                            mosi      <= tx_data[7];
                            ss1       <= 1'b1;
                            ss2       <= 1'b0;
                            ss3       <= 1'b1;
                            busy      <= 1'b1;
                            state     <= SETUP;
                        end else if (slave_sel == 2'b10) begin
                            shift_tx  <= tx_data;
                            shift_rx  <= 8'b0;
                            bit_count <= 3'b0;
                            mosi      <= tx_data[7];
                            ss1       <= 1'b1;
                            ss2       <= 1'b1;
                            ss3       <= 1'b0;
                            busy      <= 1'b1;
                            state     <= SETUP;
                        end
                    end
                end

                SETUP: begin
                    if (clk_count == CLK_DIV - 1) begin
                        clk_count <= 16'b0;
                        state     <= TRANSFER;
                    end else begin
                        clk_count <= clk_count + 1'b1;
                    end
                end

                TRANSFER: begin
                    if (clk_count == CLK_DIV - 1) begin
                        clk_count <= 16'b0;

                        if (sclk == 1'b0) begin
                            sclk     <= 1'b1;
                            shift_rx <= {shift_rx[6:0], miso};

                            if (bit_count == 3'd7) begin
                                state <= DONE_ST;
                            end else begin
                                bit_count <= bit_count + 1'b1;
                            end
                        end else begin
                            sclk     <= 1'b0;
                            shift_tx <= {shift_tx[6:0], 1'b0};
                            mosi     <= shift_tx[6];
                        end
                    end else begin
                        clk_count <= clk_count + 1'b1;
                    end
                end

                DONE_ST: begin
                    ss1     <= 1'b1;
                    ss2     <= 1'b1;
                    ss3     <= 1'b1;
                    sclk    <= 1'b0;
                    busy    <= 1'b0;
                    rx_data <= shift_rx;
                    done    <= 1'b1;
                    state   <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
