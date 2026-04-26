module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] op,
    output reg [31:0] out,
    output reg zero,
    output reg of
    );
    
    always @(*)
    begin
        case(op)
            4'b0000: out=A+B;
            4'b0001: out=A-B;
            4'b0010: out=A&B;
            4'b0011: out=A|B;
            4'b0100: out=~(A|B);
            4'b0101: out=A^B;
            4'b0110: out=(A<B)?1:0;
            default: out=31'b0;
        endcase
        zero=(out==0)?1:0;
        case({A[31], B[31], out[31]})
            3'b001, 3'b110: of=1;
            default: of=0;
        endcase
    end
endmodule

