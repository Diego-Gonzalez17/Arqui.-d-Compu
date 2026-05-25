//sumador 4 bits comportamental

module Sum_4b(
input  [3:0] A,
input  [3:0] B,
input        cin,
output [3:0] S,
output       cout
);

wire [4:0] suma;

assign suma = A + B + cin;
assign S = suma[3:0];
assign cout = suma[4];

endmodule

//sumador 8 bits con 2 de 4
module Sum_8b(
input  [7:0] A,
input  [7:0] B,
output [7:0] S,
output       cout
);

wire c1; 

// Nibble bajo
Sum_4b U1 (
    .A   (A[3:0]),
    .B   (B[3:0]),
    .cin (1'b0),
    .S   (S[3:0]),
    .cout(c1)
);

// Nibble alto
Sum_4b U2 (
    .A   (A[7:4]),
    .B   (B[7:4]),
    .cin (c1),
    .S   (S[7:4]),
    .cout(cout)
);

endmodule

