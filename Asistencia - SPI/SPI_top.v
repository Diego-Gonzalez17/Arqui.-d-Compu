module SPI_top (
    input CLK
);

wire w_miso;
wire w_mosi;
wire w_ss;
wire w_sclk;

// Instancia Master
M_MASTER master_inst (
    .clk(CLK),
    .miso(w_miso),
    .mosi(w_mosi),
    .ss(w_ss),
    .sclk(w_sclk)
);

// Instancia Slave
M_SLAVE slave_inst (
    .sclk(w_sclk),
    .ss(w_ss),
    .mosi(w_mosi),
    .miso(w_miso)
);

endmodule