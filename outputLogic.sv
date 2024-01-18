module outputLogic (
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
);
		
	assign LED_D = ~DONE;
	
	assign LED_B = BUS;
		
	//assigning displays
		
		logic [9:0] D;
		
		
		
		/*module decimal7decoder (
			input logic [3:0] D,
			output logic [0:6] Y, //seg0 - A, seg6 - G
			output logic [0:6] Z
		);*/
		
		//OLD CODE!!!
		//assign D = PEEKb ? BUS : REG;
		
		//NEW CODE FOR D!
		always_comb
		begin
			if(TIME == 2'b00 & PEEKb == 1'b1)
			begin
			D = 10'b0000000000;
			end
			else
			begin
			D = PEEKb ? BUS : REG;
			end
		end
		
		
		decimal7decoder outhex3 (
			.D({1'b0, 1'b0, D[9], D[8]}),
			.Y(DHEX2)
		);
		
		decimal7decoder outhex2 (
			.D({D[7], D[6], D[5], D[4]}),
			.Y(DHEX1)
		);
		
		decimal7decoder outhex1 (
			.D({D[3], D[2], D[1], D[0]}),
			.Y(DHEX0)
		);
		
		decimal7decoder timer (
			.D({1'b0, 1'b0, TIME[1], TIME[0]}),
			.Y(THEX)
		);
	
endmodule
