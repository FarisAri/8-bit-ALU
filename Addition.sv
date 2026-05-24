/*
Addition module: Recieves two 8-bit inputs and produces 
an 8-bit output that is the sum of the two as well as
an overflow bit

-Trenton Hamilton
*/

module Addition(
    input logic [7:0] a, b,
    output logic [7:0] y,
    output logic overflow
);

assign y = a + b;
assign overflow = y < a;

endmodule