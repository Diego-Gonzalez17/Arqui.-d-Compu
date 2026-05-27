`timescale 1ns/1ps

module SPI_tb;

    reg        clk;
    reg        rst;
    reg        start;
    reg [1:0]  slave_sel;
    reg [7:0]  master_tx_data;
    wire [7:0] master_rx_data;
    wire [7:0] slave1_rx_data;
    wire [7:0] slave2_rx_data;
    wire [7:0] slave3_rx_data;
    wire       done;
    wire       busy;
    wire       sclk;
    wire       mosi;
    wire       miso;
    wire       ss1;
    wire       ss2;
    wire       ss3;

    SPI_top uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .slave_sel(slave_sel),
        .master_tx_data(master_tx_data),
        .master_rx_data(master_rx_data),
        .slave1_rx_data(slave1_rx_data),
        .slave2_rx_data(slave2_rx_data),
        .slave3_rx_data(slave3_rx_data),
        .done(done),
        .busy(busy),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .ss1(ss1),
        .ss2(ss2),
        .ss3(ss3)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;
        slave_sel = 2'b00;
        master_tx_data = 8'h00;

        #20;
        rst = 1'b0;

        // PRUEBA 1: Maestro -> Slave 1
        #20;
        slave_sel = 2'b00;
        master_tx_data = 8'hA5;
        start = 1'b1;
        #10;
        start = 1'b0;
        wait(done == 1'b1);
        #20;

        $display("----------------------------------------");
        $display("PRUEBA 1: Slave 1 seleccionado");
        $display("Dato enviado por el maestro = %h", master_tx_data);
        $display("Dato recibido por el maestro = %h", master_rx_data);
        $display("Dato recibido por el slave 1 = %h", slave1_rx_data);
        if (master_rx_data == 8'h3C && slave1_rx_data == 8'hA5)
            $display("RESULTADO: OK");
        else
            $display("RESULTADO: ERROR");

        // PRUEBA 2: Maestro -> Slave 2
        #40;
        slave_sel = 2'b01;
        master_tx_data = 8'h6D;
        start = 1'b1;
        #10;
        start = 1'b0;
        wait(done == 1'b1);
        #20;

        $display("----------------------------------------");
        $display("PRUEBA 2: Slave 2 seleccionado");
        $display("Dato enviado por el maestro = %h", master_tx_data);
        $display("Dato recibido por el maestro = %h", master_rx_data);
        $display("Dato recibido por el slave 2 = %h", slave2_rx_data);
        if (master_rx_data == 8'hC3 && slave2_rx_data == 8'h6D)
            $display("RESULTADO: OK");
        else
            $display("RESULTADO: ERROR");

        // PRUEBA 3: Maestro -> Slave 3
        #40;
        slave_sel = 2'b10;
        master_tx_data = 8'hF0;
        start = 1'b1;
        #10;
        start = 1'b0;
        wait(done == 1'b1);
        #20;

        $display("----------------------------------------");
        $display("PRUEBA 3: Slave 3 seleccionado");
        $display("Dato enviado por el maestro = %h", master_tx_data);
        $display("Dato recibido por el maestro = %h", master_rx_data);
        $display("Dato recibido por el slave 3 = %h", slave3_rx_data);
        if (master_rx_data == 8'h5A && slave3_rx_data == 8'hF0)
            $display("RESULTADO: OK");
        else
            $display("RESULTADO: ERROR");

        $display("----------------------------------------");
        #20;
        $stop;
    end

endmodule
