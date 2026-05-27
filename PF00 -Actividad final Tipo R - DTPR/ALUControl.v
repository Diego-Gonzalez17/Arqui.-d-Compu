module ALUControl(
    input [5:0] Funct,
    input [2:0] ALUOp,
    output reg [2:0] ALUCtrl
);
    always @(*) begin
        if (ALUOp == 3'b010) begin
            case(Funct)
                6'b100000: ALUCtrl = 3'b000; // ADD
                6'b100010: ALUCtrl = 3'b001; // SUB
                6'b100100: ALUCtrl = 3'b010; // AND
                6'b100101: ALUCtrl = 3'b011; // OR
                6'b101010: ALUCtrl = 3'b100; // SLT
                default:   ALUCtrl = 3'b111;
            endcase
        end else begin
            ALUCtrl = 3'b000;
        end
    end
endmodule