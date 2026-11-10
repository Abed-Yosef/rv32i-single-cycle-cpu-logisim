module data_memory_tb;

logic clk, MemRead, MemWrite;
logic [31:0] address, WriteData;
logic [31:0] ReadData;

data_memory dut (
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .address(address),
    .WriteData(WriteData),
    .ReadData(ReadData)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    MemRead = 0;
    MemWrite = 0;
    address = 32'd108;
    WriteData = 32'd75;
    MemWrite = 1;

    @(posedge clk);
    #1;
    MemWrite = 0;

    MemRead = 1;
    #1;

    if (ReadData !== 32'd75)
        $error("MEMORY TEST FAILED");
    else
        $display("MEMORY TEST PASSED");

    $finish;

end

endmodule