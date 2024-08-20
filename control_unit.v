module control_unit (
  
 input  wire  	[6:0] 	op,
 input  wire  	[2:0] 	funct3,
 input  wire            funct7,
 input  wire            Zero,
 output reg		[1:0]	PCSrc,
 output reg		[1:0]	ResultSrc,
 output reg				MemWrite,MemRead,
 output reg				ALUSrc,
 output reg				RegWrite, 
 output reg 	[1:0] 	ImmSrc,
 output reg 	[2:0] 	ALUControl);

reg [1:0] ALUOp;
wire [1:0]	cat1;
wire [3:0]  cat2;
reg 	  Branch,Jump;

// main decoder
always @(*)
begin
	case(op)
	// LW 
	7'b0000011: begin
				RegWrite=1;
				ImmSrc=2'b00;
				ALUSrc=1;
				MemWrite=0;
				MemRead =1;
				ResultSrc=2'b01;
				Branch=0;
				ALUOp=2'b00;
				Jump = 0;
				end
	// S−type 
	7'b0100011: begin
			    RegWrite=0;
				ImmSrc=2'b01;
				ALUSrc=1;
				MemWrite=1;
				MemRead =0;
				ResultSrc=2'b01;
				Branch=0;
				ALUOp=2'b00;
				Jump = 0;
				end
	// R-type
	7'b0110011: begin
				RegWrite=1;
				ImmSrc=2'b00;
				ALUSrc=0;
				MemWrite=0;
				MemRead =0;
				ResultSrc=2'b00;
				Branch=0;
				ALUOp=2'b10;
				Jump=0;
				end
	// I-type
	7'b0010011:begin
				RegWrite=1;
				ImmSrc=2'b00;
				ALUSrc=1;
				MemWrite=0;
				MemRead =0;
				ResultSrc=2'b00;
				Branch=0;
				ALUOp=2'b10;
				Jump = 0;
				end
	//B-type
	7'b1100011: begin
				RegWrite=0;
				ImmSrc=2'b10;
				ALUSrc=0;
				MemWrite=0;
				MemRead =0;
				ResultSrc=2'b00;
				Branch=1;
				ALUOp=2'b01;
				Jump = 0;
				end
	//J-Type//////////////////////////jal only
	7'b1101111: begin
				RegWrite=1;
				ImmSrc=2'b11;
				ALUSrc=0;
				MemWrite=0;
				MemRead =0;
				ResultSrc=2'b10;
				Branch=0;
				ALUOp=2'b00;
				Jump = 1;
				end
	// I-type ////////////////////// jalr
	7'b1100111: begin
				RegWrite=1;
				ImmSrc=2'b00;
				ALUSrc=1;
				MemWrite=0;
				MemRead =0;
				ResultSrc=2'b10;
				Branch=0;
				ALUOp=2'b00;
				Jump = 1;
				end
	default:	begin
				RegWrite=0;
				ImmSrc=2'b00;
				ALUSrc=0;
				MemWrite=0;
				MemRead =0;
				ResultSrc=2'b00;
				Branch=0;
				ALUOp=2'b00;
				Jump =0;
				end
	endcase
end


// ALU decoder
assign cat1 = {op[5],funct7};

always @(*)
begin 
  case(ALUOp)
    2'b00:ALUControl=3'b000;	//add
    2'b01:ALUControl=3'b001;	// sub
    2'b10:begin // R type
			case(funct3)
			3'b000: ALUControl= cat1 == 2'b11 ? 3'b001: 3'b000;
			3'b110:	ALUControl= 3'b011;
			3'b111:	ALUControl= 3'b010;
			3'b010: ALUControl= 3'b101;
			default  :ALUControl=3'b000;
			endcase
          end
    default:ALUControl=3'b000;
  endcase
end

// PC source
assign cat2 = {op[3],funct3};
always@(*)
begin
	case(cat2)
	4'b0000:PCSrc = { Jump ,(Zero & Branch)};
	4'b0001:PCSrc= {1'b0,(~(Zero) & Branch) |Jump};
	default: PCSrc=Jump;
endcase
end



endmodule
