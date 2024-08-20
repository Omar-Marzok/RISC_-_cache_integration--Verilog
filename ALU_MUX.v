module ALU_MUX (

 input  wire 		      ALUSrc, 
 input  wire [31:0]       RD2,
 input  wire [31:0]  	  ImmExt,
 output reg  [31:0]       SrcB );

always @(*) 
begin
    if (ALUSrc) 
	begin
		SrcB = ImmExt;
	end
	else 
    begin
        SrcB = RD2; 
    end
 end
 
endmodule
