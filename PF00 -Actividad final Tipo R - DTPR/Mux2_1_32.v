module Mux2_1_32(
    input [31:0] In0,
    input [31:0] In1,
    input Sel,
    output [31:0] Out
);
    assign Out = (Sel) ? In1 : In0;
endmodule