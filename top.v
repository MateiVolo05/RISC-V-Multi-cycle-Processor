module top(
    input clk, res
);
    wire MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg;
    wire ALUSrcA;
    wire[1:0] ALUSrcB;
    wire[1:0] ALUOp;
    wire[6:0] opcode;
    wire SelCause;
    wire CauseWr;
    wire EPCWr;
    
    DataPath DataPathInst(
        .clk(clk), 
        .res(res), 
        .MemRead(MemRead), 
        .IorD(IorD), 
        .IRWrite(IRWrite), 
        .PCWrite(PCWrite), 
        .PCSource(PCSource), 
        .PCWriteCond(PCWriteCond), 
        .MemWrite(MemWrite), 
        .RegWrite(RegWrite), 
        .MemToReg(MemToReg),
        .ALUSrcA(ALUSrcA), 
        .ALUSrcB(ALUSrcB), 
        .ALUOp(ALUOp),
        .SelCause(SelCause),
        .CauseWr(CauseWr),
        .EPCWr(EPCWr),
        .opcode(opcode)
    );
    
    ControlPath ControlPathInst(
        .clk(clk), 
        .res(res), 
        .MemRead(MemRead), 
        .IorD(IorD), 
        .IRWrite(IRWrite), 
        .PCWrite(PCWrite), 
        .PCSource(PCSource), 
        .PCWriteCond(PCWriteCond), 
        .MemWrite(MemWrite), 
        .RegWrite(RegWrite), 
        .MemToReg(MemToReg),
        .ALUSrcA(ALUSrcA), 
        .ALUSrcB(ALUSrcB), 
        .ALUOp(ALUOp),
        .SelCause(SelCause),
        .CauseWr(CauseWr),
        .EPCWr(EPCWr),
        .opcode(opcode)
    );
endmodule
