module immediate_generator(
input logic [31:0] instruction,
input logic [1:0] imm_sel,
output logic [31:0] immediate
);
always_comb begin
	case (imm_sel)
		2'b00: immediate = {{20{instruction[31]}},instruction[31:20]};
		2'b01: immediate = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
		2'b10: immediate = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
		2'b11: immediate = {{11{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
		default: immediate = 32'd0;
	endcase
end
endmodule
