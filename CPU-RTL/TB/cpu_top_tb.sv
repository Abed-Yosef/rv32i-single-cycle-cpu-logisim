module cpu_top_tb;

logic clk, reset;

cpu_top dut (
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #1;
    dut.IMEM.rom[0]  = 32'h00A00093; // ADDI
    dut.IMEM.rom[1]  = 32'h00500113; // ADDI
    dut.IMEM.rom[2]  = 32'h002081B3; // ADD
    dut.IMEM.rom[3]  = 32'h40208233; // SUB
    dut.IMEM.rom[4]  = 32'h0020F2B3; // AND
    dut.IMEM.rom[5]  = 32'h0020E333; // OR
    dut.IMEM.rom[6]  = 32'h00302023; // SW
    dut.IMEM.rom[7]  = 32'h00002383; // LW
    dut.IMEM.rom[8]  = 32'h00718463; // BEQ
    dut.IMEM.rom[9]  = 32'h06300413; // Skipped
    dut.IMEM.rom[10] = 32'h008004EF; // JAL
    dut.IMEM.rom[11] = 32'h04D00513; // Skipped
    dut.IMEM.rom[12] = 32'h00100593; // ADDI
    dut.IMEM.rom[13] = 32'h00000063; // Loop

    #11;
    reset = 0;

    repeat (12) @(posedge clk);
    #1;

    if (dut.RF.registers[1] !== 32'd10)
        $error("FAIL: ADDI");

    if (dut.RF.registers[3] !== 32'd15)
        $error("FAIL: ADD");

    if (dut.RF.registers[4] !== 32'd5)
        $error("FAIL: SUB");

    if (dut.RF.registers[5] !== 32'd0)
        $error("FAIL: AND");

    if (dut.RF.registers[6] !== 32'd15)
        $error("FAIL: OR");

    if (dut.DMEM.ram[0] !== 32'd15)
        $error("FAIL: SW");

    if (dut.RF.registers[7] !== 32'd15)
        $error("FAIL: LW");

    if (dut.RF.registers[9] !== 32'd44)
        $error("FAIL: JAL");

    if (dut.RF.registers[11] !== 32'd1)
        $error("FAIL: Branch/Jump flow");

    if (dut.pc !== 32'd52)
        $error("FAIL: PC");

    $display("CPU TEST COMPLETED");
    $finish;
end

endmodule