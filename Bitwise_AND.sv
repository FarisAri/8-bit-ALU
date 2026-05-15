module Bitwise_AND(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic y
);

assign y = &(a & b);

endmodule