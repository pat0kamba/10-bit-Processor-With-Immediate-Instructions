module registerFileDNC (
input logic [9:0] D ,
input logic ENW , ENR0 , ENR1 , CLKb ,
//input logic [2:0] WRA , RDA0 , RDA1 ,
input logic [1:0] WRA , RDA0 , RDA1 ,
output logic [9:0] Q0 , Q1
);

//REGISTER FORMAT
// 0_000_XXX_YYY

//ENR1 IS ALWAYS 1'b1

//prameter list
parameter 
reg0 = 3'b000,
reg1 = 3'b001,
reg2 = 3'b010,
reg3 = 3'b011;
//reg4 = 3'b100,
//reg5 = 3'b101,
//reg6 = 3'b110,
//reg7 = 3'b111;


//logic
logic [9:0] WriteReg0;
logic [9:0] WriteReg1;
logic [9:0] WriteReg2;
logic [9:0] WriteReg3;
//logic [9:0] WriteReg4;
//logic [9:0] WriteReg5;
//logic [9:0] WriteReg6;
//logic [9:0] WriteReg7;

logic [9:0] ReadReg0;
logic [9:0] ReadReg1;
logic [9:0] ReadReg2;
logic [9:0] ReadReg3;
//logic [9:0] ReadReg4;
//logic [9:0] ReadReg5;
//logic [9:0] ReadReg6;
//logic [9:0] ReadReg7;


always_comb
begin
			WriteReg0 = 1'b0;
			WriteReg1 = 1'b0;
			WriteReg2 = 1'b0;
			WriteReg3 = 1'b0;
//			WriteReg4 = 1'b0;
//			WriteReg5 = 1'b0;
//			WriteReg6 = 1'b0;
//			WriteReg7 = 1'b0;
	
	if(ENW)
	begin	
		//WRITE registers
		case(WRA)
			reg0 : WriteReg0 = 1'b1;
			reg1 : WriteReg1 = 1'b1;
			reg2 : WriteReg2 = 1'b1;
			reg3 : WriteReg3 = 1'b1;
//			reg4 : WriteReg4 = 1'b1;
//			reg5 : WriteReg5 = 1'b1;
//			reg6 : WriteReg6 = 1'b1;
//			reg7 : WriteReg7 = 1'b1;
		endcase
		
	end

end


always_comb
begin
	//READ registers INTERNAL

	if(ENR0)	
	begin
		case(RDA0)
			reg0 : Q0 = ReadReg0;
			reg1 : Q0 = ReadReg1;
			reg2 : Q0 = ReadReg2;
			reg3 : Q0 = ReadReg3;
//			reg4 : Q0 = ReadReg4;
//			reg5 : Q0 = ReadReg5;
//			reg6 : Q0 = ReadReg6;
//			reg7 : Q0 = ReadReg7;
		endcase
	end
	else
	begin
	Q0 = 10'bzzzzzzzzzz;
	end
end

always_comb
begin
		case(RDA1)
			reg0 : Q1 = ReadReg0;
			reg1 : Q1 = ReadReg1;
			reg2 : Q1 = ReadReg2;
			reg3 : Q1 = ReadReg3;
//			reg4 : Q1 = ReadReg4;
//			reg5 : Q1 = ReadReg5;
//			reg6 : Q1 = ReadReg6;
//			reg7 : Q1 = ReadReg7;
		endcase

end
//REGISTERS

//register in/out
/*
input logic [N-1:0] D,
input logic CLKb, EN,
output logic [N-1:0] Q
*/

//ZERO
reg10 zero(
	.CLKb(CLKb),
	.EN(WriteReg0),
	.D(D),
	.Q(ReadReg0)
);

//ONE
reg10 one(
	.CLKb(CLKb),
	.EN(WriteReg1),
	.D(D),
	.Q(ReadReg1)
);

//TWO
reg10 two(
	.CLKb(CLKb),
	.EN(WriteReg2),
	.D(D),
	.Q(ReadReg2)
);

//THRE'E
reg10 three(
	.CLKb(CLKb),
	.EN(WriteReg3),
	.D(D),
	.Q(ReadReg3)
);

//FOUR
//reg10 four(
//	.CLKb(CLKb),
//	.EN(WriteReg4),
//	.D(D),
//	.Q(ReadReg4)
//);

//FIVE
//reg10 five(
//	.CLKb(CLKb),
//	.EN(WriteReg5),
//	.D(D),
//	.Q(ReadReg5)
//);

//SIX
//reg10 six(
//	.CLKb(CLKb),
//	.EN(WriteReg6),
//	.D(D),
//	.Q(ReadReg6)
//);

//SEVEN
//reg10 seven(
//	.CLKb(CLKb),
//	.EN(WriteReg7),
//	.D(D),
//	.Q(ReadReg7)
//);

endmodule