module decimal7decoder (
	input logic [3:0] D,
	output logic [0:6] Y, //seg0 - A, seg6 - G
	output logic [0:6] Z
);

	always_comb
	begin
		case(D)
			4'b1000 : //8
			begin
				Y = 7'b0000000; 
				Z = 7'b1111110;
			end
			4'b1001 : //9
			begin
				Y = 7'b0001100;
				Z = 7'b1111110;
			end
			4'b1010 : //A
			begin 
				Y = 7'b0001000;
				Z = 7'b1111110;
			end
			4'b1011 : //B
			begin
				Y = 7'b1100000;
				Z = 7'b1111110;
			end
			4'b1100 : //C
			begin
				Y = 7'b0110001;
				Z = 7'b1111110;
			end
			4'b1101 : //D
			begin
				Y = 7'b1000010;
				Z = 7'b1111110;
			end
			4'b1110 : //E
			begin
				Y = 7'b0110000;
				Z = 7'b1111110;
			end
			4'b1111 : //F
			begin
				Y = 7'b0111000;
				Z = 7'b1111110;
			end
			4'b0000 : //0
			begin
				Y = 7'b0000001;
				Z = 7'b1111111;
			end
			4'b0001 : 
			begin 
				Y = 7'b1001111;
				Z = 7'b1111111;
			end
			4'b0010 : 
			begin 
				Y = 7'b0010010;
				Z = 7'b1111111;
			end
			4'b0011 : 
			begin 
				Y = 7'b0000110;
				Z = 7'b1111111;
			end
			4'b0100 : 
			begin 
				Y = 7'b1001100;
				Z = 7'b1111111;
			end
			4'b0101 : 
			begin 
				Y = 7'b0100100;
				Z = 7'b1111111;
			end
			4'b0110 : 
			begin 
				Y = 7'b0100000;
				Z = 7'b1111111;
			end
			4'b0111 : 
			begin 
				Y = 7'b0001111;
				Z = 7'b1111111;
			end
		endcase
	end

endmodule