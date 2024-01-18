module controller(
input logic [9:0] INSTR,
input logic [1:0] T, 
output logic [9:0] IMM,
output logic [2:0] Rin,
output logic [2:0] Rout,
output logic [3:0] ALUcont,
output logic ENW, ENR, Ain, Gin, Gout, Ext, IRin, Clr,immediate
);

//	parameter 	LOAD = 4'b0000,
//					COPY = 4'b0001,
//					FLP = 4'b0010,
//					INV = 4'b0011,
//					ADD = 4'b0100,
//					SUB = 4'b0101,
//					AND = 4'b0110,
//					OR = 4'b0111;

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
					ASR = 4'b1011,
					ADDI = 2'b10,
					SUBI = 2'b11;
					
	logic [1:0] Rx;
	logic [1:0] Ry;
	
	assign Ry = INSTR[5:4];
	assign Rx = INSTR[7:6];
	
	
	
	always_comb
	begin
		//default values 
		Rin = 2'b00;
		Rout = 2'b00;
		ENW = 1'b0; 
		ENR = 1'b0; 
		Ain = 1'b0; 
		Gin = 1'b0;
		Gout = 1'b0; 
		ALUcont = 4'b0000; 
		Ext = 1'b0; 
		IRin = 1'b0; 
		Clr = 1'b0;
		immediate = 1'b0;
		IMM = 10'b0;
		case(INSTR[9:8])
			ADDI:   //ADDI
			begin
				//Clr = 1'b1;
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						ENR = 1'b1;
						Rout = INSTR[7:6];
						ALUcont = INSTR[3:0];
						Ain = 1'b1;
					end
					2'b10:
					begin
						//ENR = 0;
						IMM = {1'b0, 1'b0, 1'b0, 1'b0, INSTR[5:0]};
						immediate = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0010;
						
						//IMM = {4'b0, INSTR[5:0]};
						//IMM[5:0] = INSTR[5:0];
						
					end
					2'b11:
					begin
						//IMM = {1'b0, 1'b0, 1'b0, 1'b0, INSTR[5:0]};
						Gout = 1'b1;
						Rin = INSTR[7:6];
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			SUBI: //SUBI
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						ENR = 1'b1;
						Rout = INSTR[7:6];
						Ain = 1'b1;
					end
					2'b10:
					begin
						//IMM = {1'b0, 1'b0, INSTR[7:0]};
						IMM = {1'b0, 1'b0, 1'b0, 1'b0, INSTR[5:0]};
						immediate = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0011;
						Clr = 1'b1;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = INSTR[7:6];
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			endcase
		case(INSTR[3:0])
			LOAD:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ext = 1'b1;
						ENW = 1'b1;
						Rin = Rx;
						Clr = 1'b1;
					end
				endcase
			end
			COPY:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			FLP:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0101;
					end
					2'b10:
					begin
						Gout = 1'b1;
						ENW = 1'b1;
						Rin = Rx;
						Clr = 1'b1;
					end
				endcase
			end
			INV:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0100;
					end
					2'b10:
					begin
						Gout = 1'b1;
						ENW = 1'b1;
						Rin = Rx;
						Clr = 1'b1;
					end
				endcase
			end
			ADD:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0010;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			SUB:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0011;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			AND:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0110;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			OR:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b0111;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			XOR:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b1000;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			LSL:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b1001;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			LSR:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b1010;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
			ASR:
			begin
				case(T)
					2'b00:
					begin
						IRin = 1'b1;
						Ext = 1'b1;
					end
					2'b01:
					begin
						Ain = 1'b1;
						Rout = Rx;
						ENR = 1'b1;
					end
					2'b10:
					begin
						Rout = Ry;
						ENR = 1'b1;
						Gin = 1'b1;
						ALUcont = 4'b1011;
					end
					2'b11:
					begin
						Gout = 1'b1;
						Rin = Rx;
						ENW = 1'b1;
						Clr = 1'b1;
					end
				endcase
			end
		//endcase

//			3'b110: //ANDI
//			begin
//				case(T)
//					2'b00:
//					begin
//						IRin = 1'b1;
//						Ext = 1'b1;
//						IMM = {1'b1, 1'b1, 1'b1, 1'b1, INSTR[6:1]};
//					end
//					2'b01:
//					begin
//						ENR = 1'b1;
//						Rout = INSTR[0];
//						Ain = 1'b1;
//						IMM = {1'b1, 1'b1, 1'b1, 1'b1, INSTR[6:1]};
//					end
//					2'b10:
//					begin
//						immediate = 1'b1;
//						IMM = {1'b1, 1'b1, 1'b1, 1'b1, INSTR[6:1]};
//						Gin = 1'b1;
//						ALUcont = 3'b110;
//					end
//					2'b11:
//					begin
//						IMM = {1'b1, 1'b1, 1'b1, 1'b1, INSTR[6:1]};
//						Gout = 1'b1;
//						Rin = INSTR[0];
//						ENW = 1'b1;
//						Clr = 1'b1;
//					end
//				endcase
//			end
//			3'b111:  //ORI
//			begin
//			case(T)
//					2'b00:
//					begin
//						IRin = 1'b1;
//						Ext = 1'b1;
//					end
//					2'b01:
//					begin
//						ENR = 1'b1;
//						Rout = INSTR[0];
//						Ain = 1'b1;
//					end
//					2'b10:
//					begin
//						IMM = {1'b0, 1'b0, 1'b0, 1'b0, INSTR[6:1]};
//						immediate = 1'b1;
//						Gin = 1'b1;
//						ALUcont = 3'b111;
//					end
//					2'b11:
//					begin
//						Gout = 1'b1;
//						Rin = INSTR[0];
//						ENW = 1'b1;
//						Clr = 1'b1;
//					end
		endcase
		end
		//endcase
		
//	end
endmodule