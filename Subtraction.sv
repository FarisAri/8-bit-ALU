// Project : Subtraction
// Author  : Trenton Hamilton
// Date    : 6/1/2026
// Description: Subtracts two 8-bit numbers
// Sources : None

module Subtraction(
    input logic [7:0] a, b,
    output logic [7:0] y
);

logic [7:0] twos_complement_b;

assign twos_complement_b = ~b + 1'b1;
assign y = a + twos_complement_b;

endmodule