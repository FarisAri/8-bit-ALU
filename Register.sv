module Register#(parameter N = 8)(
    input logic CLK,
    input logic reset_n,
    input logic [N-1:0] d,
    input logic enable,
    output logic [N-1:0] q
);

always_ff @(posedge CLK or negedge reset_n) begin
<<<<<<< HEAD
    if (!reset_n)
        q <= '0;
    else if (enable)
        q <= d;
=======
    if (reset_n === 1'b0) begin
        q <= 1'h0;
	end else begin
		  q <= d;
	end
>>>>>>> c31d20eecc1ebd90250d5c72ea7864a9bbb1da9e
end

endmodule