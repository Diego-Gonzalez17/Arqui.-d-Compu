module SPI_top (
    input  wire       clk,
    input  wire       rst,
    input  wire       start,
    input  wire [1:0] slave_sel,
    input  wire [7:0] master_tx_data,
    output wire [7:0] master_rx_data,
    output wire [7:0] slave1_rx_data,
    output wire [7:0] slave2_rx_data,
    output wire [7:0] slave3_rx_data,
    output wire       done,
    output wire       busy,
    output wire       sclk,
    output wire       mosi,
    output wire       miso,
    output wire       ss1,
    output wire       ss2,
    output wire       ss3
);

    wire miso_1;
    wire miso_2;
    wire miso_3;

    assign miso = (!ss1) ? miso_1 :
                  (!ss2) ? miso_2 :
                  (!ss3) ? miso_3 :
                  1'b0;

    M_MASTER #(
        .CLK_DIV(4)
    ) master_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .slave_sel(slave_sel),
        .tx_data(master_tx_data),
        .miso(miso),
        .mosi(mosi),
        .sclk(sclk),
        .ss1(ss1),
        .ss2(ss2),
        .ss3(ss3),
        .rx_data(master_rx_data),
        .busy(busy),
        .done(done)
    );

    M_SLAVE #(
        .RESPONSE_BYTE(8'h3C)
    ) slave_1 (
        .rst(rst),
        .sclk(sclk),
        .ss(ss1),
        .mosi(mosi),
        .miso(miso_1),
        .rx_data(slave1_rx_data),
        .rx_done()
    );

    M_SLAVE #(
        .RESPONSE_BYTE(8'hC3)
    ) slave_2 (
        .rst(rst),
        .sclk(sclk),
        .ss(ss2),
        .mosi(mosi),
        .miso(miso_2),
        .rx_data(slave2_rx_data),
        .rx_done()
    );

    M_SLAVE #(
        .RESPONSE_BYTE(8'h5A)
    ) slave_3 (
        .rst(rst),
        .sclk(sclk),
        .ss(ss3),
        .mosi(mosi),
        .miso(miso_3),
        .rx_data(slave3_rx_data),
        .rx_done()
    );

endmodule
