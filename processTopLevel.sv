module processTopLevel(
	input logic [9:0] data,
	input  logic CLKb, CLK50M, PKb,
	output logic [9:0] LED_B,
	output logic [0:6] DHEX0,
	output logic [0:6] DHEX1,
	output logic [0:6] DHEX2,
	output logic [0:6] THEX,
	output logic LED_D
);

	logic dbCLK;

		//Debouncer clk button
		/*
		input logic A_noisy,
		input logic CLK50M, 
		output logic A
		*/
	
		debouncer FuncCLK(
			.A_noisy(CLKb),
			.CLK50M(CLK50M),
			.A(dbCLK)
		);
		
	logic dbPEEK;

		//Debouncer peek button
		/*
		input logic A_noisy,
		input logic CLK50M, 
		output logic A
		*/
	
		debouncer FuncPK(
			.A_noisy(PKb),
			.CLK50M(CLK50M),
			.A(dbPEEK)
		);
	
	logic Ext;
	
	logic [9:0] dataBus;
	
	logic [9:0] dataBusALU;
	
	logic [9:0] dataBusRF;
	
	logic [9:0] dataBusIMM;
	
	always_comb
	begin 
		if(Ext)
			dataBus = data; 
		else
			dataBus = 10'bzzzzzzzzzz;
	end 
	
	always_comb
	begin 
		if(Gout)
			dataBus = dataBusALU; 
		else 
			dataBus = 10'bzzzzzzzzzz;
	end 
	
	always_comb
	begin 
		if(ENR0)
			dataBus = dataBusRF; 
		else 
			dataBus = 10'bzzzzzzzzzz;
	end 
	
	always_comb
	begin 
		if(immediate)
			dataBus = dataBusIMM; 
		else 
			dataBus = 10'bzzzzzzzzzz;
	end
	
	
	//instruction register
		
		/*module reg10#(
			parameter N = 10 //variable width register
		)
		(
			input logic [N-1:0] D,
			input logic CLKb, EN,
			output logic [N-1:0] Q
		);*/
		
		logic [9:0] instr;
		logic IRin;
		
		reg10 instrReg(
			.D(dataBus),
			.EN(IRin),
			.CLKb(dbCLK),
			.Q(instr)
		);
	
	//counter
	
		/*module upcount2 (
		input logic CLR , CLKb ,
		output logic [1:0] CNT
		);*/
		
		logic Clr;
		logic [1:0] CNT;
		
		upcount2 counter(
			.CLR(Clr),
			.CLKb(dbCLK),
			.CNT(CNT)
		);
		
	//Register File
	
		/*module registerFile (
		input logic [9:0] D ,
		input logic ENW , ENR0 , ENR1 , CLKb ,
		input logic [2:0] WRA , RDA0 , RDA1 ,
		output logic [9:0] Q0 , Q1
		);*/
		
		logic ENW, ENR0;
		logic [1:0] WRA, RDA0;
		logic [9:0] REG;
		
		registerFileDNC rgF(
			.D(dataBus),
			.ENW(ENW),
			.ENR0(ENR0),
			.ENR1(1'b1),
			.CLKb(dbCLK),
			.WRA(WRA),
			.RDA0(RDA0),
			.RDA1({data[1:0]}),
			.Q0(dataBusRF),
			.Q1(REG)
		);
		
	//controller
	
		/*module controller(
		input logic [9:0] INSTR,
		input logic [1:0] T, 
		output logic [9:0] IMM,
		output logic [2:0] Rin,
		output logic [2:0] Rout,
		output logic ENW, ENR, Ain, Gin, Gout, ALUcont, Ext, IRin, Clr
		);*/
		
		logic immediate;
		logic Ain;
		logic Gin;
		logic Gout;
		logic [3:0] FN;
		
		controller cntrlr(
			.INSTR(instr),
			.T(CNT),
			.IMM(dataBus),
			.Rin(WRA),
			.Rout(RDA0),
			.ENW(ENW),
			.ENR(ENR0),
			.Ain(Ain),
			.Gin(Gin),
			.Gout(Gout),
			.ALUcont(FN),
			.Ext(Ext),
			.IRin(IRin),
			.Clr(Clr),
			.immediate(immediate)
		);
		
	//ALU
		
		/*module ALU(
			input logic [9:0] OP,
			input  logic Ain, Gin, Gout, CLKb,
			input  logic [2:0] FN, //ALUControl
			output logic [9:0] RES,
		);*/
		
		ALU alu(
			.OP(dataBus),
			.Ain(Ain),
			.Gin(Gin),
			.Gout(Gout),
			.CLKb(dbCLK),
			.FN(FN),
			.RES(dataBusALU)
		);
		
	//Output Logic
	
		/*module outputLogic (
			input logic [9:0] BUS,
			input logic [9:0] REG,
			input logic [1:0] TIME,
			input logic PEEKb,
			input logic DONE,
			output logic [9:0] LED_B,
			output logic [0:6] DHEX0,
			output logic [0:6] DHEX1,
			output logic [0:6] DHEX2,
			output logic [0:6] THEX,
			output logic LED_D
		);*/
		
		outputLogic outLog(
			.BUS(dataBus),
			.REG(REG),
			.TIME(CNT),
			.PEEKb(dbPEEK),
			.DONE(Clr),
			.LED_B(LED_B),
			.DHEX0(DHEX0),
			.DHEX1(DHEX1),
			.DHEX2(DHEX2),
			.THEX(THEX),
			.LED_D(LED_D)
		);
		

endmodule