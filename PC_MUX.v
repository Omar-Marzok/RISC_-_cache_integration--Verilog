module PC_MUX (

 input  wire [1:0]		  PCSrc, 
 input  wire [31:0]       PC,
 input  wire [31:0]  	  ImmExt,
 input  wire [31:0]  	  ALUResult,
 output reg  [31:0]       PC_next,
 output	wire [31:0]   	  PC_plus4
 );

wire [31:0]  PC_target; 
 
always @(*) 
begin
	case(PCSrc)
	2'b00: PC_next = PC_plus4;
	2'b01: PC_next = PC_target;
	2'b10: PC_next = ALUResult;
	default:PC_next = PC_plus4;
	endcase
 end
 
 assign PC_plus4 = PC + 32'd4 ;
 assign PC_target = PC + ImmExt ;
endmodule



