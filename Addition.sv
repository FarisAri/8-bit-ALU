// Project : Addition
// Author  : Trenton Hamilton
// Date    : 6/1/2026
// Description: Adds two 8-bit numbers and detects overflow
// Sources : None

module Addition(
    input logic [7:0] a, b,
    output logic [7:0] y,
    output logic overflow
);

assign y = a + b;
assign overflow = y < a;

endmodule