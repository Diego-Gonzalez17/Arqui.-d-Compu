module BancoReg(
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    input RegWrite,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);
    reg [31:0] registros [0:31];
    integer i;

    initial begin
        for(i=0; i<32; i=i+1) registros[i] = i; // Inicializa R1=1, R2=2, etc.
    end

    assign ReadData1 = registros[ReadReg1];
    assign ReadData2 = registros[ReadReg2];

    always @(RegWrite or WriteReg or WriteData) begin
        if (RegWrite && WriteReg != 0)
            registros[WriteReg] <= WriteData;
    end
endmodule
