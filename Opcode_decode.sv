// Project : Opcode_decode
// Author  : Anthony Nguyen
// Date    : 6/1/2026
// Description: Decodes opcode and selects ALU output accordingly
// Sources : None
module Opcode_decode(
    input logic [3:0] opcode,
    input logic [7:0] reg1,
    input logic [7:0] reg2,
    output logic [7:0] y,
    output logic carry_out
);

// ALU operator outputs
logic [7:0] add_sum, sub_result, and_result, xor_result, or_result, 
            output_a_result, output_b_result, mult_result, mod_result;
logic add_carry, mult_overflow;

// Operator instantiations
Addition add_inst (
    .a(reg1),
    .b(reg2),
    .y(add_sum),
    .overflow(add_carry)
);

Subtraction sub_inst (
    .a(reg1),
    .b(reg2),
    .y(sub_result)
);

Bitwise_AND and_inst (
    .a(reg1),
    .b(reg2),
    .y(and_result)
);

Bitwise_XOR xor_inst (
    .a(reg1),
    .b(reg2),
    .y(xor_result)
);

Bitwise_OR or_inst (
    .a(reg1),
    .b(reg2),
    .y(or_result)
);

Output_Operand output_a_inst (
    .a(reg1),
    .y(output_a_result)
);

Output_Operand output_b_inst (
    .a(reg2),
    .y(output_b_result)
);

Multiplication mult_inst (
    .a(reg1),
    .b(reg2),
    .y(mult_result),
    .overflow(mult_overflow)
);

Modulo mod_inst (
    .a(reg1),
    .b(reg2),
    .y(mod_result)
);

// Combinational logic to select ALU output and carry based on opcode
always_comb begin
    case (opcode)
        4'b0000: begin // Add
            y = add_sum;
            carry_out = add_carry;
        end
        4'b0001: begin // Subtract
            y = sub_result;
            carry_out = 0;
        end
        4'b0010: begin // AND
            y = and_result;
            carry_out = 0;
        end
        4'b0011: begin // Output A
            y = output_a_result;
            carry_out = 0;
        end
        4'b0100: begin // Output B
            y = output_b_result;
            carry_out = 0;
        end
        4'b0101: begin // XOR
            y = xor_result;
            carry_out = 0;
        end
        4'b0110: begin // OR
            y = or_result;
            carry_out = 0;
        end
        4'b0111: begin // Multiply
            y = mult_result;
            carry_out = mult_overflow;
        end
        4'b1000: begin // Modulo
            y = mod_result;
            carry_out = 0;
        end
        default: begin
            y = 8'b0;
            carry_out = 0;
        end
    endcase
end
endmodule