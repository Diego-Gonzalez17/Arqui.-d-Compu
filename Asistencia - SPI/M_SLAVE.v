module M_SLAVE (
    input sclk,
    input ss,
    input mosi,
    output reg miso
);

// Ejemplo simple: eco (loopback)
always @(posedge sclk) begin
    if (!ss)
        miso <= mosi;
end

endmodule