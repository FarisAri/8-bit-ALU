module Multiplication(
    input logic [7:0] a, b,
    output logic [7:0] y,
    output logic overflow
);

logic [15:0] full_product;

assign full_product = a * b;
assign y = full_product[7:0];
assign overflow = |full_product[15:8];

endmodule