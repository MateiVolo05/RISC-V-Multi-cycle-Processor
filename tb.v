module tb();

reg clk, res;
top DUT(.clk(clk), .res(res));

initial
begin
    #0 clk=1'b0;res=1'b1;
    forever #10 clk=~clk;
end
initial
begin
    #25 res=1'b0;
    #1
        DUT.DataPathInst.RegistersInst.mem[1] = 32'h7FFFFFFF;
        DUT.DataPathInst.RegistersInst.mem[2] = 32'h00000001;
        DUT.DataPathInst.RegistersInst.mem[4] = 32'd10;
        DUT.DataPathInst.RegistersInst.mem[5] = 32'd10;
    #200 $finish;
end    
endmodule
