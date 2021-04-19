module testmicro(
	input clk,
	output reg oclk,
	output reg oclk2
);

reg [26:0] counter;
reg [23:0] counter2;

always @(posedge clk) 
	begin
		 if (counter == 0) 
		 begin
			  counter <= 24999999;
			  oclk <= ~oclk;
		 end 
		 else 
		 begin
			  counter <= counter -1;
		 end
	end
	
always @(posedge clk) 
	begin
		 if (counter2 == 0) 
		 begin
			  counter2 <= 9999999;
			  oclk2 <= ~oclk2;
		 end 
		 else 
		 begin
			  counter2 <= counter2 -1;
		 end
	end
endmodule
