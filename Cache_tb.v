module cache_tb;
	reg clk;
	reg [31:0]Address;
	wire [31:0]Data_Out;
	wire Hit_Miss;
	//temporary variables used  for the file handling
	integer fileo,filec,r,r1,r2;
	integer count =0;
	wire [31:0]rate;
	reg [20:0]str;
	reg [7:0]line;
	Cache uut(
		.clk(clk),
		.Data_Out(Data_Out),
		.Address(Address),
		.Hit_Miss(Hit_Miss),
		.rate(rate)
	);
	initial begin
		$dumpfile("cache.vcd");
		$dumpvars(0,cache_tb);
		clk = 0;Address = 32'b0;#30; 		//Initializing and initial delay
		//file handling for address request
		fileo = $fopenr("gcc2.trace");
		if(!fileo)
			$display("ERROR : CANNOT OPEN FILE\n");
		else
		begin
			while(!$feof(fileo))
			begin
				if($fgets(line,fileo))
				begin
					if(count<2)
						count+=1;
					else if(count<10)
					begin
						if(line<97)
						begin
							Address[(4*(10-count))-1-:4] = (line-48);
							count += 1;
						end
						else
						begin
							Address[(4*(10-count))-1-:4] = (line-87);
							count += 1;
						end

					end
					else
					begin
//						$display("%d %d %h",Hit_Miss,Data_Out,Address);
						#5;
						count = 0;
					end
				end
			end
		end
	end
	initial begin
	repeat(100)#5 clk = ~clk;
	end
endmodule
