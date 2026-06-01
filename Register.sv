// Project : Register
// Author  : Trenton Hamilton
// Date    : 6/1/2026
// Description: An N-bit register with synchronous reset and enable
// Sources : None

module Register#(parameter N = 8)(
    input logic CLK,
    input logic reset_n,
    input logic [N-1:0] d,
    input logic enable,
    output logic [N-1:0] q
);

always_ff @(posedge CLK or negedge reset_n) begin
    if (!reset_n)
        q <= '0;
    else if (enable)
        q <= d;
end

endmodule