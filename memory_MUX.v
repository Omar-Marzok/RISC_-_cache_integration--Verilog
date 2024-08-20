module memory_MUX (

 input  wire [1:0]		  ResultSrc, 
 input  wire [31:0]       RD,
 input  wire [31:0]  	  ALUResult,
 input	wire [31:0]   	  PC_plus4,
 output reg  [31:0]       Result );

always @(*) 
begin
	case(ResultSrc)
	2'b00: Result = ALUResult;
	2'b01: Result = RD;
	2'b10: Result = PC_plus4;
	default: Result = ALUResult;
	endcase
 end
 
endmodule





