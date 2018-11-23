module FInput();

integer fileo,filec,r,r1,r2;

reg[20:0] str;

reg [7:0]line;

reg [31:0]Address = 0;

integer count = 0;
initial begin
    $display("Started");
    fileo = $fopenr("gcc.trace");
    if(!fileo) $display("ERROR: CAN NOT OPEN THE FILE!");

    $display("Looping");
    while(!$feof(fileo))
    begin
       if($fgets(line,fileo))
        begin
           $display("L",line);
           $display("C",count);
            if(count<2)
             count+=1;
            else if(count<10)
                begin
                $display(line);
                 if(line<97)
                  begin
                    $display("CC1",count);
                    Address[(4*(10-count))-1-:4] = (line-48);
                    $display("V = %b",Address[(4*(10-count))-1+:4]);
                    count+=1;
                  end
                 else
                  begin
                    $display("CC2",count);
                    Address[(4*(10-count))-1-:4] = (line-87);
                    $display("V ",Address[4*(10-count)-1+:4]);
                    count+=1;
                  end
                end
            else
             count =0;
        end
    end
    $display("%h",Address);
  end
endmodule
