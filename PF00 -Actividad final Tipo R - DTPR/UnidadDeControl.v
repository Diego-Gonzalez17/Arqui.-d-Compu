module UnidadDeControl(
    input [5:0] OpCode,
    output reg MemToReg,
    output reg RegWrite,
    output reg MemToWrite,
    output [2:0] ALUOp
);
    assign ALUOp = 3'b010; 

    always @(*) begin
        if (OpCode == 6'b000000) begin 
            RegWrite = 1'b1;
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
        end else begin
            RegWrite = 1'b0;
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
        end
    end
endmodule