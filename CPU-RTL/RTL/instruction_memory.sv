module instruction_memory(
input logic [31:0] pc,
output logic [31:0] instruction
);
logic [31:0] rom [0:255];
assign instruction = rom[pc[9:2]];
endmodule