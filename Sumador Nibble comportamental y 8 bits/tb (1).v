`timescale 1ns/1ps

module tb_sumadores;

reg  [3:0] A4, B4;
reg        cin;
wire [3:0] S4;
wire       cout4;


reg  [7:0] A8, B8;
wire [7:0] S8;
wire       cout8;

Sum_4b DUT4 (
    .A(A4),
    .B(B4),
    .cin(cin),
    .S(S4),
    .cout(cout4)
);


Sum_8b DUT8 (
    .A(A8),
    .B(B8),
    .S(S8),
    .cout(cout8)
);


initial begin

    $display("===== INICIO SIMULACION =====");

    A4 = 0; B4 = 0; cin = 0;
    A8 = 0; B8 = 0;

    #10 A4 = 4'b0101; B4 = 4'b0011; cin = 0;   
    #10 A4 = 4'b1111; B4 = 4'b0001; cin = 0;   
    #10 A4 = 4'b1010; B4 = 4'b0101; cin = 1;  

    #20;

    #10 A8 = 8'b00001111; B8 = 8'b00000001;   
    #10 A8 = 8'b11111111; B8 = 8'b00000001;  
    #10 A8 = 8'b10101010; B8 = 8'b01010101;   

    #20 $finish;

end

endmodule 