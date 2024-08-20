module PC (
  
 input  wire [31:0]       PC_next,
 input  wire              clk,
 input  wire              RST,
 output reg  [31:0]       PC );


always @(posedge clk, negedge RST) 
begin
    if (!RST) 
	begin
		PC <= 32'b0 ;
	end
	else 
    begin
        PC <= PC_next; 
    end
 end
 
endmodule


