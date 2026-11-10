module cpu_top (
input logic clk, reset
);
logic [31:0] pc, pc_plus_4, instruction;
logic [31:0] immediate, read_data_1, read_data_2;
logic [31:0] alu_b, alu_result, mem_data, write_data;
logic [6:0] opcode, funct7;
logic [4:0] rs1, rs2, rd;
logic [2:0] funct3;
logic RegWrite, ALUSrc, MemRead, MemWrite;
logic Branch, Jump, zero;
logic [1:0] ResultSrc, ImmSel, ALUOp, ALU_Control;

program_counter PC_UNIT (
    .clk(clk),
    .reset(reset),
    .immediate(immediate),
    .branch(Branch),
    .zero(zero),
    .jump(Jump),
    .pc(pc),
    .pc_plus_4(pc_plus_4)
);

instruction_memory IMEM (
    .pc(pc),
    .instruction(instruction)
);

instruction_splitter SPLITTER (
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);

main_control CONTROL (
    .opcode(opcode),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .Jump(Jump),
    .ResultSrc(ResultSrc),
    .ImmSel(ImmSel),
    .ALUOp(ALUOp)
);

immediate_generator IMM_GEN (
    .instruction(instruction),
    .imm_sel(ImmSel),
    .immediate(immediate)
);

register_file RF (
    .clk(clk),
    .reg_write(RegWrite),
    .read_address_1(rs1),
    .read_address_2(rs2),
    .write_address(rd),
    .write_data(write_data),
    .read_data_1(read_data_1),
    .read_data_2(read_data_2)
);

alu_control ALU_CTRL (
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALU_Control(ALU_Control)
);

assign alu_b = ALUSrc ? immediate : read_data_2;

ALU ALU_UNIT (
    .A(read_data_1),
    .B(alu_b),
    .alu_control(ALU_Control),
    .result(alu_result)
);

assign zero = (alu_result == 32'd0);

data_memory DMEM (
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .address(alu_result),
    .WriteData(read_data_2),
    .ReadData(mem_data)
);

always_comb begin
    case (ResultSrc)
        2'b00: write_data = alu_result;
        2'b01: write_data = mem_data;
        2'b10: write_data = pc_plus_4;
        default: write_data = 32'd0;
    endcase
end
endmodule