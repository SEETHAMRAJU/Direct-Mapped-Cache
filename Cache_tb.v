module cache_tb;
	reg clk;
	reg [31:0]Address;
	wire [31:0]Data_Out;
	wire Hit_Miss;
	Cache uut(
		.clk(clk),
		.Data_Out(Data_Out),
		.Address(Address),
		.Hit_Miss(Hit_Miss)
	);
	initial begin
		clk = 0;
		Address = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		#10;
		$display("Cache hit = %b data=>%b",Hit_Miss,Data_Out);
		Address = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		#10;
		$display("Cache hit = %b data=>%b",Hit_Miss,Data_Out);
		Address = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		#10;
		$display("Cache hit = %b data=>%b add=%b\n",Hit_Miss,Data_Out,Address);
		#10;
		Address = 32'b0000_0000_0000_0000_0000_0000_0000_1100;
		$display("Cache hit = %b data=>%b add=%b\n",Hit_Miss,Data_Out,Address);
		#10;
		$display("Cache hit = %b data=>%b add=%b\n",Hit_Miss,Data_Out,Address);
		#10;
		$display("Cache hit = %b data=>%b add=%b\n",Hit_Miss,Data_Out,Address);

	end
	initial begin
	repeat(20)#5 clk = ~clk;
end
endmodule
