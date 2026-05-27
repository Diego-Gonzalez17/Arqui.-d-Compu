module DPTR(
    input [31:0] InstruccionTR
);
    // Cables de control
    wire MemToReg, RegWrite, MemToWrite;
    wire [2:0] ALUOp, ALUCtrl;
    
    // Cables de datos
    wire [31:0] RD1, RD2, ALURes, MemRD, WData;
    wire ZF;

    // 1. Unidad de Control (Asegúrate que el archivo se llame UnidadDeControl.v)
    UnidadDeControl UC (
        .OpCode(InstruccionTR[31:26]), 
        .MemToReg(MemToReg), 
        .RegWrite(RegWrite), 
        .MemToWrite(MemToWrite), 
        .ALUOp(ALUOp)
    );

    // 2. Banco de Registros (Archivo BancoReg.v)
    BancoReg BR (
        .ReadReg1(InstruccionTR[25:21]), 
        .ReadReg2(InstruccionTR[20:16]),
        .WriteReg(InstruccionTR[15:11]), 
        .WriteData(WData), 
        .RegWrite(RegWrite),
        .ReadData1(RD1), 
        .ReadData2(RD2)
    );

    // 3. ALU Control (OJO: En tu imagen dice ALUControl.v sin la 'u' minúscula intermedia)
    ALUControl AC (
        .Funct(InstruccionTR[5:0]), 
        .ALUOp(ALUOp), 
        .ALUCtrl(ALUCtrl)
    );

    // 4. ALU (Archivo ALU.v)
    ALU MiALU (
        .OP1(RD1), 
        .OP2(RD2), 
        .ALUCtrl(ALUCtrl), 
        .Res(ALURes), 
        .ZF(ZF)
    );

    // 5. Memoria (Archivo Mem.v)
    Mem MiMem (
        .Address(ALURes), 
        .WriteData(RD2), 
        .MemWrite(MemToWrite), 
        .ReadData(MemRD)
    );

    // 6. Multiplexor (Archivo Mux2_1_32.v)
    Mux2_1_32 MuxFinal (
        .In0(ALURes), 
        .In1(MemRD), 
        .Sel(MemToReg), 
        .Out(WData)
    );

endmodule