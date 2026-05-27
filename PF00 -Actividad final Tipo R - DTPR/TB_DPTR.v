`timescale 1ns/1ps
module TB_DPTR();
    reg [31:0] Instr;
    DPTR dut (.InstruccionTR(Instr));

    initial begin
        // Formato: OP(0) - RS - RT - RD - Shamt(0) - Funct
        
        // 1. ADD: $8 = $16 + $17  -> 0x02114020
        Instr = 32'h02114020; #20;
        // 2. SUB: $9 = $18 - $19  -> 0x02534822
        Instr = 32'h02534822; #20;
        // 3. AND: $10 = $20 & $21 -> 0x02955024
        Instr = 32'h02955024; #20;
        // 4. OR:  $11 = $22 | $23 -> 0x02D75825
        Instr = 32'h02D75825; #20;
        // 5. SLT: $12 = ($24 < $25) ? 1 : 0 -> 0x0319602A
        Instr = 32'h0319602A; #20;
        
        // Repetir otras 5 instrucciones con diferentes registros para completar las 10
        Instr = 32'h02324020; #20; // ADD
        Instr = 32'h02544822; #20; // SUB
        Instr = 32'h02955024; #20; // AND
        Instr = 32'h02D75825; #20; // OR
        Instr = 32'h0319602A; #20; // SLT

        $stop;
    end
endmodule