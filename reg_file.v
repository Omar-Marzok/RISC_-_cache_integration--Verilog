module reg_file (
  
 input  wire  [4:0]       A1,
 input  wire  [4:0]       A2,
 input  wire  [4:0]       A3,
 input  wire              clk,
 input  wire              RST,
 input  wire              WE3,
 input  wire  [31:0]      WD3,
 output wire  [31:0]      RD1,
 output wire  [31:0]      RD2 );

reg [31:0] Reg_File [31:0];

always @(posedge clk, negedge RST) 
begin
        if (!RST) 
		begin
			Reg_File[0] <= 32'b0 ;
		end
		else if (WE3 && A3 != 0)
        begin
            Reg_File[A3] <= WD3; 
        end
        else
        begin
            Reg_File[0] <= 32'b0 ;
        end
 end
 
 assign RD1 = Reg_File[A1];
 assign RD2 = Reg_File[A2];
 
endmodule


