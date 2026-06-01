// Project : Modulo
// Author  : Trenton Hamilton
// Date    : 6/1/2026
// Description: Computes the modulo of two 8-bit numbers
// Sources : None

module Modulo(
    input logic [7:0] a, b,
    output logic [7:0] y
);

assign y = a % b;

endmodule