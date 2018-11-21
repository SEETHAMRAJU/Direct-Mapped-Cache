module Cache(clk, Address, Data_Out, Hit_Miss);
    input [31:0] Address;
    input clk;
    output reg [31:0] Data_Out;
    output reg Hit_Miss;

    reg [31:0] [15:0] Cache_Memory[255:0];
    reg [17:0] Cache_Tags[255:0];

    reg [17:0] Tag_Bits;
    reg [7:0] Index_Bits;
    reg [3:0] Byte_Offset;

    initial begin
        Tag_Bits = Address[31:14];
        Index_Bits = Address[13:6];
        Byte_Offset = Address[5:2];
    end

    always@(Address)
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
endmodule
