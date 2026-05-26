// Name: Bitwise_AND
// Author  : Faris Ari
// Date    : 5/24/2026
// Description: Returns the AND of two 8-bit inputs
// Sources : Textbook

module Bitwise_AND(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] y
);

assign y = a & b;

endmodule