module M_SLAVE #(
    parameter [7:0] RESPONSE_BYTE = 8'h3C
)(
    input  wire      rst,
    input  wire      sclk,
    input  wire      ss,
    input  wire      mosi,
    output reg       miso,
    output reg [7:0] rx_data,
    output reg       rx_done
);

    reg [7:0] shift_tx;
    reg [7:0] shift_rx;
    reg [2:0] bit_count;

    always @(posedge rst or negedge ss) begin
        if (rst) begin
            shift_tx  <= RESPONSE_BYTE;
            shift_rx  <= 8'b0;
            bit_count <= 3'b0;
            miso      <= 1'b0;
            rx_data   <= 8'b0;
            rx_done   <= 1'b0;
        end else begin
            shift_tx  <= RESPONSE_BYTE;
            shift_rx  <= 8'b0;
            bit_count <= 3'b0;
            miso      <= RESPONSE_BYTE[7];
            rx_done   <= 1'b0;
        end
    end

    always @(posedge sclk or posedge rst) begin
        if (rst) begin
            shift_rx  <= 8'b0;
            bit_count <= 3'b0;
            rx_data   <= 8'b0;
            rx_done   <= 1'b0;
        end else if (!ss) begin
            shift_rx <= {shift_rx[6:0], mosi};

            if (bit_count == 3'd7) begin
                rx_data <= {shift_rx[6:0], mosi};
                rx_done <= 1'b1;
            end else begin
                bit_count <= bit_count + 1'b1;
                rx_done   <= 1'b0;
            end
        end
    end

    always @(negedge sclk or posedge rst) begin
        if (rst) begin
            shift_tx <= RESPONSE_BYTE;
            miso     <= 1'b0;
        end else if (!ss) begin
            shift_tx <= {shift_tx[6:0], 1'b0};
            miso     <= shift_tx[6];
        end
    end

endmodule
