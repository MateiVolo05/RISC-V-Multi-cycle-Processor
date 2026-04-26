module ALUcontrol(
    input[31:0] IR,
    input[1:0] ALUOp,
    output reg[3:0] op
    );
    
    always@(*)
        casex({ALUOp, IR[14:12], IR[31:25]})
            12'b00_xxx_xxxxxxx: op=4'b0000;
            12'b01_xxx_xxxxxxx: op=4'b0001;
            12'b10_000_0000000: op=4'b0000;
            12'b10_010_0000000: op=4'b0110;
            12'b10_100_0000000: op=4'b0101;
            12'b10_110_0000000: op=4'b0011;
            12'b10_111_0000000: op=4'b0010;
            12'b10_000_0100000: op=4'b0001;
        endcase
endmodule
