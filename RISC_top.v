module RISC_top
(
    input	clk, 
	input  	RST
	);

wire [31:0] PC, Instr, PCNext, Result, SrcA, SrcB, WriteData, ImmExt, ALUResult, ReadData, PCPlus4;
wire [2:0] ALUControl;
wire [1:0] ResultSrc, ImmSrc,PCSrc;
wire RegWrite, Zero, MemWrite, ALUSrc, stall, MemRead;


instruction_memory instruction_memory_i
(
	.A(PC),
	.RD(Instr)
);

reg_file reg_file_i
(
	.clk(clk),
	.RST(RST),
	.WE3(RegWrite),
	.A1(Instr[19:15]),
	.A2(Instr[24:20]),
	.A3(Instr[11:7]),
	.WD3(Result),
	.RD1(SrcA),
	.RD2(WriteData)
);

control_unit control_unit_i
(
	.funct3(Instr[14:12]),
	.funct7(Instr[30]),
	.op(Instr[6:0]),
	.Zero(Zero),
	.MemWrite(MemWrite),
	.ResultSrc(ResultSrc),
	.ALUSrc(ALUSrc),
	.ImmSrc(ImmSrc),
	.RegWrite(RegWrite),
	.ALUControl(ALUControl),
	.PCSrc(PCSrc),
	.MemRead(MemRead)
);

extend_unit extend_unit_i
(
	.Instr(Instr[31:7]),
	.ImmSrc(ImmSrc),  	
	.ImmExt(ImmExt)
);

ALU_MUX ALU_MUX_i
(
	.RD2(WriteData), 
	.ImmExt(ImmExt), 
	.ALUSrc(ALUSrc),
	.SrcB(SrcB)
);

PC_MUX PC_MUX_i
(
	.PC_plus4(PCPlus4), 
	.ImmExt(ImmExt),
	.PC(PC),
	.ALUResult(ALUResult),
	.PCSrc(PCSrc),
	.PC_next(PCNext)
);

ALU ALU_i
(
    .SrcA(SrcA), 
	.SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

memory_MUX memory_MUX_i
(
	.ALUResult(ALUResult),
    .RD(ReadData),
    .PC_plus4(PCPlus4),
    .ResultSrc(ResultSrc),
    .Result(Result)
);

PC PC_i
(
	.PC_next(PCNext),
    .clk(clk & !stall), 
	.RST(RST),
    .PC(PC)
);

cache_top cache_data_system 
(
.clk(clk),
.RST(RST),
.RE(MemRead),
.WE(MemWrite),
.A(ALUResult[9:0]),
.DataIn(WriteData),
.DataOut(ReadData),
.stall(stall)
);


endmodule
