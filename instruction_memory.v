module instruction_memory(

input  wire [31:0] A,
output wire [31:0] RD
);
	reg [31:0] I_mem [0:255];	// Define a 64-word (256-byte) memory

initial
begin
	$readmemh ("inst_mem.txt",I_mem); // Load memory contents from a file
end

assign RD = I_mem[A >> 2];  // Word-aligned memory access

endmodule

