module Cache(clk, Address, Data_Out, Hit_Miss,rate);
	input wire [31:0] Address; 			//the input address that is given
	input clk; 					//clk for syncheonization
	output reg [31:0] Data_Out; 			//for the data that will be returned from cache
	output reg Hit_Miss; 				//set if there is a hit else 0 for miss
    	output reg [31:0]rate;
   	
	reg [15:0] [31:0] Cache_Memory[256:0]; 		//a memory of registers 256 x 16 words ,where 1 word is 32 bits.
    	reg [17:0] Cache_Tags[256:0]; 			//a set of registers for the tag bits
	//reg [7:0] memory[0:32767]; 			// the main memory
	reg [7:0]memory[0:8388607];
	reg [15:0] [31:0] Cache_Memory[255:0]; 		//a memory of registers 256 x 16 words ,where 1 word is 32 bits.
    	reg [17:0] Cache_Tags[255:0]; 			//a set of registers for the tag bits
	//reg [7:0] memory[0:32767]; 			// the main memory
	reg [7:0]memory[0:8388608];
	//set of registers used for storing parts of the addess like tag bits,
	// index bits etc. for ease of working.
	reg [17:0] Tag_Bits; 				 
    	reg [7:0] Index_Bits; 				
    	reg [3:0] Byte_Offset; 			
	//set of temporary registers required for future purposes
	reg [31:0]temp; 		
	reg [31:0]temp2; 			
	reg [31:0]temp3; 		
	integer i;
	integer j;
	integer count;
	//this reads the data into the actual main memory from the file
	//"memory.list"
	initial begin
		$readmemb("memory.list",memory);	
		count = 0;
		rate = 32'b0;
	end
	//Here in this block we seperate the address to tag bits , index bits
	//etc. and then check for the address in the cache .Incase of a miss
	//we proceed to the next block
	always@(posedge clk)
    	begin
	        Tag_Bits = Address[31:14];
        	Index_Bits = Address[13:6];
	        Byte_Offset = Address[5:2];
		count+=1;
    		M = 32'b0000_0000_0000_0000_0000_0000_0000_1111;
		if(Cache_Tags[Index_Bits] == Tag_Bits)
        	begin
			Hit_Miss = 1;
        	    	Data_Out = Cache_Memory[Index_Bits][Byte_Offset];
		end
        	else
        	begin
            		Hit_Miss = 0;
        	end
    	end
    	//This is the code for getting the block of data if there is a cache miss. 
    	//here we are anding with the a given numebr to make the last 6 bits
	//0 and start from the firt location of the required bloack of data. 
		if(Hit_Miss == 0)
		begin
			rate = rate + 1;
			count+=1;
			temp3 = Address & 32'b11111111_11111111_11111111_11000000;
			for(i=0;i<16;i++)
			begin
				temp = 0;
				temp = temp | temp3;
				temp3 = temp3+4;
				for(j=0;j<4;j++)
				begin
					temp2 = temp2<<8;
					temp2 = temp2 | memory[temp+j];
				end
				//Assigning the data in the memory 
				Cache_Memory[Index_Bits][i] = temp2;
			end
			Cache_Tags[Index_Bits] = Address[31:14];
    			Data_Out = Cache_Memory[Index_Bits][Byte_Offset] ;
		end
	end
endmodule
