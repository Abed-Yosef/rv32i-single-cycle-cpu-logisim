module main_control (
input logic [6:0] opcode,
output logic RegWrite, ALUSrc, MemRead, MemWrite, Branch, Jump,
output logic [1:0] ResultSrc, ImmSel, ALUOp
);

logic is_R_type, is_ADDI, is_LW, is_SW, is_BEQ, is_JAL;
assign is_R_type = (opcode == 7'h33);
assign is_ADDI   = (opcode == 7'h13);
assign is_LW     = (opcode == 7'h03);
assign is_SW     = (opcode == 7'h23);
assign is_BEQ    = (opcode == 7'h63);
assign is_JAL    = (opcode == 7'h6F);
assign RegWrite = is_R_type | is_ADDI | is_LW | is_JAL;
assign ALUSrc   = is_ADDI | is_LW | is_SW;
assign MemRead  = is_LW;
assign MemWrite = is_SW;
assign Branch   = is_BEQ;
assign Jump     = is_JAL;
assign ResultSrc = {is_JAL, is_LW};
assign ImmSel = {is_BEQ | is_JAL , is_SW | is_JAL};
assign ALUOp = {is_R_type, is_BEQ};
endmodule