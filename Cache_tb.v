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
		$dumpfile("cache.vcd");
		$dumpvars(0,cache_tb);
		clk = 0;
		$display("Direct Mapped Cache");
		$display("---------------------------------------------------------------------\n");
		Address = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		#30;
		$display("Hit=%b Data=%h address=%h\n",Hit_Miss,Data_Out,Address);
		#5;
		Address = 32'b0000_0000_0000_0000_0000_0000_0000_1100;
		#5;
		$display("Hit=%b Data=%h address=%h\n",Hit_Miss,Data_Out,Address);

	end
	initial begin
	repeat(50)#5 clk = ~clk;
end
endmodule
