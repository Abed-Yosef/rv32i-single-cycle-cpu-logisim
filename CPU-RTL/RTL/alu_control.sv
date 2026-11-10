module alu_control (
    input logic [1:0] ALUOp,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic [1:0] ALU_Control
);
logic is_SUB, is_AND, is_OR;
assign is_SUB = (ALUOp == 2'b01) | ((ALUOp == 2'b10) && (funct3 == 3'b000) && (funct7 == 7'b0100000));
assign is_AND = (ALUOp == 2'b10) && (funct3 == 3'b111) && (funct7 == 7'b0000000);
assign is_OR = (ALUOp == 2'b10) && (funct3 == 3'b110) && (funct7 == 7'b0000000);
assign ALU_Control = {is_OR | is_AND, is_SUB | is_AND};
endmodule