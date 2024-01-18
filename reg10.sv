module reg10#(
	parameter N = 10 //variable width register
)
(
	input logic [N-1:0] D,
	input logic CLKb, EN,
	output logic [N-1:0] Q
);

	//negedge register with synchronous active-high enable
	always_ff@(negedge CLKb)
	begin
		if(EN)
			Q <= D;
		else
			Q <= Q;
	end

endmodule 
