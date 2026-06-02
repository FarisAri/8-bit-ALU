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




// Register instantiations
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

// Opcode decoder instantiation
Opcode_decode opcode_decode_inst (
    .opcode(opcode),
    .reg1(reg1),
    .reg2(reg2),
    .y(y),
    .carry_out(carry_out)
);

// Display instantiation
Display display_inst (
    .reg1(reg1),
    .reg2(reg2),
    .y(y),
    .segment0(segment0),
    .segment1(segment1),
    .segment2(segment2),
    .segment3(segment3),
    .segment4(segment4),
    .segment5(segment5)
);

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
