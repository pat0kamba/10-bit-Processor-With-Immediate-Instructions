module upcount2 (
input logic CLR , CLKb ,
output logic [1:0] CNT
);

    always @(negedge CLKb /*or negedge CLR*/) 
		begin
        if (CLR == 1'b1) 
				begin
					CNT <= 2'b00;
				end 
			else if (CNT == 2'b11) 
				begin
					CNT <= 2'b00;
				end 
			else 
				begin
					CNT <= CNT + 1'b1;
				end
		end
	 
endmodule