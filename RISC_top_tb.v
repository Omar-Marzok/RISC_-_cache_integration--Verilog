module RISC_top_tb();
    reg              clk;
    reg             rst;

    // instantiate device to be tested
    RISC_top dut(
	.clk(clk), 
	.RST(rst) );
	
    // initialize test
    initial
    begin
        rst <= 1; 
		# 2; 
		rst <= 0;
		# 7;
		rst <= 1;
		#500 $stop;
    end
	
    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end
	
 endmodule
