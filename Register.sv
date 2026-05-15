module Register#(parameter N)(
    input logic CLK,
    input logic reset_n,
    input logic [N-1:0] d,
    output logic [N-1:0] q
);

always_ff @(posedge CLK or negedge reset_n) begin
    q <= d;
end

endmodule