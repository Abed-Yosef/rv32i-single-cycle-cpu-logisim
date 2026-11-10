module alu_control_tb;

logic [1:0] ALUOp;
logic [2:0] funct3;
logic [6:0] funct7;
logic [1:0] ALU_Control;

alu_control dut (
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALU_Control(ALU_Control)
);

initial begin

    // ADD
    ALUOp = 2'b10;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;
    if (ALU_Control !== 2'b00)
        $error("ADD FAILED");

    // SUB
    funct7 = 7'b0100000;
    #10;
    if (ALU_Control !== 2'b01)
        $error("SUB FAILED");

    // OR
    funct3 = 3'b110;
    funct7 = 7'b0000000;
    #10;
    if (ALU_Control !== 2'b10)
        $error("OR FAILED");

    // AND
    funct3 = 3'b111;
    #10;
    if (ALU_Control !== 2'b11)
        $error("AND FAILED");

    // BEQ
    ALUOp = 2'b01;
    #10;
    if (ALU_Control !== 2'b01)
        $error("BEQ FAILED");

    $display("ALU CONTROL TEST COMPLETED");
    $finish;

end

endmodule