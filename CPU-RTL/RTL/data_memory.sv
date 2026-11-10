module data_memory (
    input logic clk, MemRead, MemWrite,
    input logic [31:0] address, WriteData,
    output logic [31:0] ReadData
);
logic [31:0] ram [0:255];
always_ff @(posedge clk) begin
    if (MemWrite)
        ram[address[9:2]] <= WriteData;
end
always_comb begin
    if (MemRead)
        ReadData = ram[address[9:2]];
    else
        ReadData = 32'd0;
end
endmodule