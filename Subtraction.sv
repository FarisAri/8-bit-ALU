/*
Subtraction module: Recieves two 8-bit inputs and produces 
an 8-bit output that is the difference of the two as well as
an underflow bit

-Trenton Hamilton
*/

module Subtraction(
    input logic [7:0] a, b,
    output logic [7:0] y
);

logic [7:0] twos_complement_b;

assign twos_complement_b = ~b + 1'b1;
assign y = a + twos_complement_b;

endmodule