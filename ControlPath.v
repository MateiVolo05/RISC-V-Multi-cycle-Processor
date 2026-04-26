module ControlPath(
    input [6:0] opcode,
    input clk, res,
    output reg MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg,
    output reg ALUSrcA, 
    output reg [1:0] ALUSrcB, 
    output reg [1:0] ALUOp,
    output reg SelCause,
    output reg CauseWr,
    output reg EPCWr
    );
    
    reg [3:0] cs;
    reg [3:0] ns;
    
    always @(cs or opcode)
    begin
        casex({cs, opcode})
            11'b0000_XXXXXXX: ns=4'b0001;
            11'b0001_0110011: ns=4'b0110; //R-Type
            11'b0001_0100011, 11'b0001_0000011: ns=4'b0010; //LW & SW
            11'b0001_1100011: ns=4'b1000; //BEQ
            11'b0010_0000011: ns=4'b0011; //LW
            11'b0010_0100011: ns=4'b0101; //SW
            11'b0011_XXXXXXX: ns=4'b0100;
            11'b0100_XXXXXXX: ns=4'b0000;
            11'b0101_XXXXXXX: ns=4'b0000;
            11'b0110_XXXXXXX: ns=4'b0111;
            11'b0111_XXXXXXX: ns=4'b0000;
            11'b1000_XXXXXXX: ns=4'b0000;
            11'b1001_xxxxxxx: ns=4'b0000;
            default: ns=4'b1001;
        endcase
    end
    
    always @(posedge clk)
    begin
        if(res)
            cs<=4'b0000;
        else
           cs<=ns;
    end
    
    always @(cs)
    begin
        case(cs)
            4'b0000: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b1_0_1_1_0_0_0_0_0_0_01_00_0_0_0;
            4'b0001: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_0_0_0_0_0_0_10_00_0_0_0;
            4'b0010: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_0_0_0_0_0_1_10_00_0_0_0;
            4'b0011: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b1_1_0_0_0_0_0_0_0_0_00_00_0_0_0;
            4'b0100: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_0_0_0_1_1_0_00_00_0_0_0;
            4'b0101: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_1_0_0_0_0_1_0_0_0_00_00_0_0_0;
            4'b0110: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_0_0_0_0_0_1_00_10_0_0_0;
            4'b0111: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_0_0_0_1_0_0_00_00_0_0_0;
            4'b1000: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_1_1_0_0_0_1_00_01_0_0_0;
            4'b1001: {MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg, ALUSrcA, ALUSrcB, ALUOp, SelCause, CauseWr, EPCWr} = 17'b0_0_0_0_0_0_0_0_0_0_00_00_1_1_1;
        endcase
    end
endmodule
