module ALU(
    input [31:0] OP1,
    input [31:0] OP2,
    input [2:0] ALUCtrl,
    output reg [31:0] Res,
    output ZF
);
    assign ZF = (Res == 32'd0);

    always @(*) begin
        case(ALUCtrl)
            3'b000: Res = OP1 + OP2;       // ADD
            3'b001: Res = OP1 - OP2;       // SUB
            3'b010: Res = OP1 & OP2;       // AND
            3'b011: Res = OP1 | OP2;       // OR
            3'b100: Res = (OP1 < OP2) ? 32'd1 : 32'd0; // SLT (Op. Ternario)
            default: Res = 32'd0;
        endcase
    end
endmodule