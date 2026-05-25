module M_MASTER (
    input clk,
    input miso,
    output reg mosi,
    output reg ss,
    output reg sclk
);

// Ejemplo simple: solo genera reloj y SS
initial begin
    ss = 1;
    sclk = 0;
end

always @(posedge clk) begin
    sclk <= ~sclk;  // genera reloj SPI
end

endmodule