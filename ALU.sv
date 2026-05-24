// Project : ALU
// Author  : Anthony Nguyen
// Date    : 5/24/2026
// Description: Performs various operations on 8 bit numbers and displays them
// Sources : None


module ALU(
    input logic [7:0] num,
    input logic clk,
    input logic rst,
    output logic [6:0] segment0,
    output logic [6:0] segment1,
    output logic [6:0] segment2,
    output logic [6:0] segment3,    
    output logic [6:0] segment4,
    output logic [6:0] segment5,
    output logic carry_out

);

// Internal signals
logic [1:0] state;
logic [7:0] reg1, reg2;
logic [7:0] y; // Output of ALU operations
logic [3:0] opcode; // ALU operation code (stored during state 10)

// ALU operator outputs
logic [7:0] add_sum, sub_result, and_result, xor_result, or_result, output_a_result, output_b_result;
logic add_carry;

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

// Display logic 
SevenSegmentDecode decode1 (
    .digit(reg1[7:4]),
    .segments(segment5)
);
SevenSegmentDecode decode2 (
    .digit(reg1[3:0]),
    .segments(segment4)
);
SevenSegmentDecode decode3 (
    .digit(reg2[7:4]),
    .segments(segment3)
);
SevenSegmentDecode decode4 (
    .digit(reg2[3:0]),
    .segments(segment2)
);
SevenSegmentDecode decode5 (
    .digit(y[7:4]),
    .segments(segment1)
);
SevenSegmentDecode decode6 (
    .digit(y[3:0]),
    .segments(segment0)
);

// Register instantiations with enable signals
Register reg1_inst (
    .CLK(clk),
    .reset_n(rst),
    .d(num),
    .enable(state == 2'b00),
    .q(reg1)
);

Register reg2_inst (
    .CLK(clk),
    .reset_n(rst),
    .d(num),
    .enable(state == 2'b01),
    .q(reg2)
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
        default: begin
            y = 8'b0;
            carry_out = 0;
        end
    endcase
end

// State machine for ALU operations
always_ff @(posedge clk or posedge ~rst) begin
    if (~rst) begin
        state <= 2'b00; // Reset state
        opcode <= 4'b1111; // Default to no operation
    end else if (state == 2'b00) begin
        state <= 2'b01; // Move to next state
    end else if (state == 2'b01) begin
        state <= 2'b10; // Move to next state
    end else if (state == 2'b10) begin
        opcode <= num[3:0]; // Load opcode during state 10
        state <= 2'b11; // Move to output state
    end else if (state == 2'b11) begin
        // Output state, results are displayed through the seven-segment decoders
        state <= 2'b11; // Stay in output state
    end
end
endmodule
