module Mem(
    input [31:0] Address,
    input [31:0] WriteData,
    input MemWrite,
    output [31:0] ReadData
);
reg [31:0] ram [0:255];
    integer i;

    // Inicialización para evitar las 'X' rojas en ModelSim
    initial begin
        for(i=0; i<64; i=i+1) begin
            ram[i] = 32'd0;
        end
    end

    // Lectura asíncrona
    assign ReadData = ram[Address[5:0]];

    // Escritura síncrona (basada en sensibilidad)
    always @(MemWrite or Address or WriteData) begin
        if (MemWrite)
            ram[Address[5:0]] <= WriteData;
    end
endmodule