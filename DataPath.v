module DataPath(
    input clk, res, MemRead, IorD, IRWrite, PCWrite, PCSource, PCWriteCond, MemWrite, RegWrite, MemToReg,
    input ALUSrcA, 
    input [1:0] ALUSrcB, 
    input [1:0] ALUOp,
    input SelCause,
    input CauseWr,
    input EPCWr,
    output reg [6:0] opcode
    );
    
    reg[31:0] PC;
    reg[31:0] IR;
    reg[31:0] ALUout;
    reg[31:0] A;
    reg[31:0] B;
    reg[31:0] MDR;
    reg[31:0] EPC;
    reg[31:0] Cause;
    
    wire[31:0] Address;
    wire[31:0] memOut;
    wire[31:0] WriteData;
    wire[31:0] ALUrez;
    wire zero;
    wire[31:0] ALUa;
    wire[31:0] ALUb;
    wire[31:0] imm;
    wire[3:0] op;
    wire[31:0] ra;
    wire[31:0] rb;
    wire[31:0] newPC;
    wire of;
    
    assign Address=(IorD==0)?PC:ALUout;
    assign WriteData=(MemToReg==1)?MDR:ALUout;
    assign ALUa=(ALUSrcA==0)?PC:A;
    assign ALUb=(ALUSrcB==2'b00)?B:(ALUSrcB==2'b01)?32'd4:imm;
    assign newPC=(PCSource==0)?ALUrez:ALUout;
    
    always @(posedge clk)
    begin
        if(res)
            PC<=32'b0;
        else
            if(PCWrite | (zero & PCWriteCond))
                PC<=newPC;
    end
    always @(posedge clk)
    begin
        if(res)
            EPC<=32'b0;
        else
            if(EPCWr)
                EPC<=PC;
    end
    always @(posedge clk)
    begin
        if(res)
            Cause<=32'b0;
        else
            if(of)
                Cause<=32'd1;
            else
                if(CauseWr)
                    Cause<=32'd2;
            
    end
    
    Memory MemoryInst(
        .clk(clk),
        .addr(Address),
        .din(B),
        .wen(MemWrite),
        .dout(memOut),
        .ren(MemRead)
    );
    
    always @(posedge clk)
    begin
        if(IRWrite)
        begin
            IR<=memOut;
            opcode<=memOut[6:0];
        end
        MDR<=memOut;
    end
    
    Registers RegistersInst(
        .clk(clk),
        .res(res),
        .wen(RegWrite),
        .ra(IR[19:15]),
        .rb(IR[24:20]),
        .rc(IR[11:7]),
        .dc(WriteData),
        .da(ra),
        .db(rb)
    );
    
    always @(posedge clk)
    begin
        A<=ra;
        B<=rb;
    end
    
    ALU ALUinst(
        .A(ALUa),
        .B(ALUb),
        .op(op),
        .out(ALUrez),
        .zero(zero),
        .of(of)
    );
    
    ImmGen ImmGenInst(
        .IR(IR),
        .imm(imm)
    );
    
    ALUcontrol ALUcontrolInst(
        .IR(IR),
        .ALUOp(ALUOp),
        .op(op)
    );
    
    always @(posedge clk)
        ALUout<=ALUrez;
endmodule
