module compuertas_logicas(
input wire A,
input wire B,
output wire AND,
output wire NAND,
output wire OR,
output wire NOR,
output wire NOT,
output wire XOR,
output wire XNOR
);

assign AND = A & B;
assign NAND = ~(A & B); 
assign OR = A | B;
assign NOR = ~(A | B) ;
assign NOT = ~A;
assign XOR = A ^ B;
assign XNOR = ~(A ^ B);

endmodule