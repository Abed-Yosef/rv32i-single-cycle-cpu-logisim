module ALU (
input logic [31:0] A, B,
input logic [1:0] ALU_CONTROL ,
output logic [31:0] ALU_RESULT ,
output logic ZERO
);
شمصصشalways_comb begin
	case (ALU_CONTROL)
		2'b00: ALU_RESULT = A + B;
		2'b01: ALU_RESULT = A - B;
		2'b10: ALU_RESULT = A | B;
		2'b11: ALU_RESULT = A & B;
		default: ALU_RESULT = 32'b0;
	endcase	
	
	ZERO = (ALU_RESULT == 32'b0);
end
endmodule