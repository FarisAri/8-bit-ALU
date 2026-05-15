module Addition(
    input logic [7:0] a, b,
    output logic [7:0] y,
    output logic overflow
);

assign y = a + b;
assign overflow = y < a;

endmodule