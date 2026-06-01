// Project : Display
// Author  : Anthony Nguyen
// Date    : 6/1/2026
// Description: Displays ALU output on seven-segment displays
// Sources : None
module Display(
    input logic [7:0] reg1,
    input logic [7:0] reg2,
    input logic [7:0] y,
    output logic [6:0] segment0,
    output logic [6:0] segment1,
    output logic [6:0] segment2,
    output logic [6:0] segment3,    
    output logic [6:0] segment4,
    output logic [6:0] segment5
);
// Display logic 
SevenSegmentDecode decode1 (
    .digit(reg1[7:4]),
    .segments(segment5)
);
SevenSegmentDecode decode2 (
    .digit(reg1[3:0]),
    .segments(segment4)
);
SevenSegmentDecode decode3 (
    .digit(reg2[7:4]),
    .segments(segment3)
);
SevenSegmentDecode decode4 (
    .digit(reg2[3:0]),
    .segments(segment2)
);
SevenSegmentDecode decode5 (
    .digit(y[7:4]),
    .segments(segment1)
);
SevenSegmentDecode decode6 (
    .digit(y[3:0]),
    .segments(segment0)
);

endmodule