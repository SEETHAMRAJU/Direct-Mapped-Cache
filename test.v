module test(in,out);
	input in;
	output out;
	reg clk = 0;
	reg [2:0] [1:0] memory[0:3];
	reg [1:0] tempmem[0:2];
	initial begin
		$readmemb("memory.list",tempmem);
		memory[0][0] = tempmem[0];
		memory[0][2] = tempmem[2];
		memory[0][1] = tempmem[0];
	end
endmodule
