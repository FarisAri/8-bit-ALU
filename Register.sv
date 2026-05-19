module Register#(parameter N)(
    input logic CLK,
    input logic reset_n,
    input logic [N-1:0] d,
    output logic [N-1:0] q
);

always_ff @(posedge CLK or negedge reset_n) begin
    if (reset_n === 1'b0) begin
        q <= 1'h0;
	end else begin
		  q <= d;
	end
end

endmodule