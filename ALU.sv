module ALU(
	input logic [9:0] OP,
	input  logic Ain, Gin, Gout, CLKb, 
	input  logic [3:0] FN, //ALUControl
	output logic [9:0] RES
);
	
//	parameter 	LOAD = 3'b000,
//				COPY = 3'b001,
//				FLP = 3'b010,
//				INV = 3'b011,
//				ADD = 3'b100,
//				SUB = 3'b101,
//				AND = 3'b110,
//				OR = 3'b111;

	parameter 	LOAD = 4'b0000,
					COPY = 4'b0001,
					ADD = 4'b0010,
					SUB = 4'b0011,
					INV = 4'b0100,
					FLP = 4'b0101,
					AND = 4'b0110,
					OR = 4'b0111,
					XOR = 4'b1000,
					LSL = 4'b1001,
					LSR = 4'b1010,
					ASR = 4'b1011;
		
	logic [9:0] A;
	
	/*module reg10#(
		parameter N = 10 //variable width register
		)
		(
			input logic [N-1:0] D,
			input logic CLKb, EN,
			output logic [N-1:0] Q
	);*/
	
	reg10 regA (
		.D(OP),
		.EN(Ain),
		.CLKb(CLKb),
		.Q(A)
	);
	
	logic [9:0] _RES;
	
	always_comb
	begin
	_RES = 10'b0;
	
		case(FN)
			LOAD:
			begin
				_RES = OP;
			end
			COPY:
			begin
				_RES = OP;
			end
			ADD :
			begin
				_RES = A + OP;
			end
			SUB :
			begin
				_RES = A - OP;
			end
			INV:
			begin
				_RES = ~OP + 1'b1;
			end
			FLP:
			begin
				_RES = ~OP;
			end
			AND :
			begin
				_RES = A & OP;
			end
			OR :
			begin
				_RES = A | OP;
			end
			XOR :
			begin
				_RES = A ^ OP;
			end
			LSL :
			begin
				_RES = A << OP;
			end
			LSR :
			begin
				_RES = A >> OP;
			end
			ASR :
			begin
				_RES = A >>> OP;
			end
		endcase
	end

	logic [9:0] _G;

	reg10 regG (
		.D(_RES),
		.EN(Gin),
		.CLKb(CLKb),
		.Q(_G)
	);

	assign RES = Gout ? _G : 10'bzz_zzzz_zzzz;

endmodule 