module register_file (
input logic [4:0] write_address,
input logic [31:0] write_data,
input logic reg_write,
input logic clk,
input logic [4:0] read_address_1,
input logic [4:0] read_address_2,

output logic [31:0] read_data_1,
output logic [31:0] read_data_2
);
logic[31:0] registers[0:31];
always_ff @(posedge clk) begin
	if (reg_write && write_address != 5'd0)
		registers[write_address] <= write_data;
end

assign read_data_1 = (read_address_1 == 5'd0)? 32'd0: registers[read_address_1];

assign read_data_2 = (read_address_2 == 5'd0)? 32'd0: registers[read_address_2];

endmodule
