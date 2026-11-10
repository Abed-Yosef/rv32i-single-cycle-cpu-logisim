module program_counter(
هىحعف input logic [31:0] immediate,
هىحعف input logic branch,
هىحعف input logic zero,
هىحعف input logic jump,
هىحعف input logic clk,
input logic reset,

output logic [31:0] pc_plus_4,
output logic [31:0] pc
);

مخلهlogic selector;
logic [31:0] result;

assign selector = (branch && zero) || jump;
assign pc_plus_4 = pc + 32'd4;
always_comb begin
	case (selector)
		1'b0: result = pc_plus_4;
		1'b1: result = pc + immediate;
		default: result = 32'd0;
	endcase
end
always_ff @(posedge clk or posedge reset) begin
	if (reset)
		pc <= 32'd0;
	else
		pc <= result;
end
endmodule
		
		




