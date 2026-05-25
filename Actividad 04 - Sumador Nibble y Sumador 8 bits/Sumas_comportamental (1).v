//sumador 4 bits comportamental
module Sum_4b(
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] S,
    output cout
);

wire [4:0] suma;

assign suma = A + B;
assign S    = suma[3:0];
assign cout = suma[4];

endmodule


// Sumador 8 bits comportamental
module Sum_8b(
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] S,
    output cout
);

wire [8:0] suma;

assign suma = A + B;
assign S    = suma[7:0];
assign cout = suma[8];

endmodule

//testbench 4 bits

`timescale 1ns/1ps
module Tb_Sum4b;

reg  [3:0] A;
reg  [3:0] B;
wire [3:0] S;
wire cout;

// Instancia del modulo
Sum_4b uut (
    .A(A),
    .B(B),
    .S(S),
    .cout(cout)
);

initial begin
    $display("A    B    | S    cout");
    $monitor("%b + %b = %b   %b", A, B, S, cout);

    A = 4'b0000; B = 4'b0000; #10;
    A = 4'b0011; B = 4'b0101; #10;
    A = 4'b1111; B = 4'b0001; #10;
    A = 4'b1010; B = 4'b0110; #10;
    A = 4'b1111; B = 4'b1111; #10;

    $finish;
end

endmodule

//testbench 8 bits

`timescale 1ns/1ps
module Tb_Sum8b;

reg  [7:0] A;
reg  [7:0] B;
wire [7:0] S;
wire cout;

// Instancia del modulo
Sum_8b uut (
    .A(A),
    .B(B),
    .S(S),
    .cout(cout)
);

initial begin
    $display("A        B        | S        cout");
    $monitor("%b + %b = %b   %b", A, B, S, cout);

    A = 8'b00000000; B = 8'b00000000; #10;
    A = 8'b00001111; B = 8'b00000001; #10;
    A = 8'b11111111; B = 8'b00000001; #10;
    A = 8'b10101010; B = 8'b01010101; #10;
    A = 8'b11111111; B = 8'b11111111; #10;

    $finish;
end

endmodule

