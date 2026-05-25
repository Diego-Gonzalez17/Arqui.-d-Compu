module M_XOR(//MODULO XOR
    input wire a,
    input wire b,
    output wire c
);
    assign c = a ^ b;
endmodule

module M_AND(//MODULO AND
    input wire a,
    input wire b,
    output wire c
);
    assign c = a & b;
endmodule

module M_OR(//MODULO OR
    input wire a,
    input wire b,
    output wire c
);
    assign c = a | b;
endmodule

//HALF ADDER
module HA(
    input  e1,
    input  e2,
    output s,
    output a
);
    M_AND torta (.a(e1), .b(e2), .c(a));
    M_XOR tamal (.a(e1), .b(e2), .c(s));
endmodule

//FINAL ADDER
module FA(
    input  x,
    input  y,
    input  cin,
    output s,
    output cout
);

    wire s1;
    wire c1;
    wire c2;
    HA ha1 (.e1(x),.e2(y),.s(s1),.a(c1));
    HA ha2 (.e1(s1),.e2(cin),.s(s),.a(c2));
    M_OR or1 (.a(c1),.b(c2),.c(cout));

endmodule

// SUMADOR DE 4 BITS 
module Sum_instancia4b(
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] S,
    output Cout
);

    wire c1, c2, c3;

    // Bit 0 -> Half Adder
    HA ha0 (.e1(A[0]), .e2(B[0]), .s(S[0]), .a(c1));

    // Bits 1 a 3 -> Full Adders
    FA fa1 (.x(A[1]), .y(B[1]), .cin(c1), .s(S[1]), .cout(c2));
    FA fa2 (.x(A[2]), .y(B[2]), .cin(c2), .s(S[2]), .cout(c3));
    FA fa3 (.x(A[3]), .y(B[3]), .cin(c3), .s(S[3]), .cout(Cout));

endmodule

// SUMADOR DE 8 BITS
module Sum_instancia8b(
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] S,
    output Cout
);

    wire c1, c2, c3, c4, c5, c6, c7;

    // Bit 0 -> Half Adder
    HA ha0 (.e1(A[0]), .e2(B[0]), .s(S[0]), .a(c1));

    // Bits 1 a 7 -> Full Adders
    FA fa1 (.x(A[1]), .y(B[1]), .cin(c1), .s(S[1]), .cout(c2));
    FA fa2 (.x(A[2]), .y(B[2]), .cin(c2), .s(S[2]), .cout(c3));
    FA fa3 (.x(A[3]), .y(B[3]), .cin(c3), .s(S[3]), .cout(c4));
    FA fa4 (.x(A[4]), .y(B[4]), .cin(c4), .s(S[4]), .cout(c5));
    FA fa5 (.x(A[5]), .y(B[5]), .cin(c5), .s(S[5]), .cout(c6));
    FA fa6 (.x(A[6]), .y(B[6]), .cin(c6), .s(S[6]), .cout(c7));
    FA fa7 (.x(A[7]), .y(B[7]), .cin(c7), .s(S[7]), .cout(Cout));

endmodule


