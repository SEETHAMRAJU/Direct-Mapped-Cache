module Cache(clk, Address, Data_Out, Hit_Miss);
	input wire [31:0] Address;
	input clk;
	output reg [31:0] Data_Out;
	output reg Hit_Miss;
    
    	reg [31:0] [15:0] Cache_Memory[255:0];
    	reg [17:0] Cache_Tags[255:0];
	reg [7:0] memory[0:1023];

    	reg [17:0] Tag_Bits;
    	reg [7:0] Index_Bits;
    	reg [3:0] Byte_Offset;
    	reg [31:0] M;
	integer i;
	always@(posedge clk)
    	begin
	        Tag_Bits = Address[31:14];
        	Index_Bits = Address[13:6];
	        Byte_Offset = Address[5:2];
    		M = 32'b0000_0000_0000_0000_0000_0000_0000_1111;
		$readmemb("memory.list",memory);	
	end

    	always@(Address,posedge clk)
    	begin
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
    //here we are anding with the M 
	always@(posedge clk)
    	begin
		$display("index = %b tag = %b in cache = %b memory=%b",Index_Bits,Tag_Bits,Cache_Memory[Index_Bits][0],memory[3]);
		if(Hit_Miss == 0)
		begin
			for(i=Address;i<Address+16;i++)
			begin
				Cache_Memory[Index_Bits][i] = memory[i]  ;
			end
			Cache_Tags[Index_Bits] <= Address[31:14];
    		end
	end
endmodule
