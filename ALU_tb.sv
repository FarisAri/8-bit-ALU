// Project : ALU_tb
// Author  : Anthony Nguyen
// Date    : 5/24/2026
// Description: Testbench for ALU module, verifies functionality of all operations
// Sources : testbench file from lab5

module ALU_tb;

    // Test signals
    logic [7:0] num;
    logic clk;
    logic rst;
    logic [6:0] segment0, segment1, segment2, segment3, segment4, segment5;
    logic carry_out;
    logic [7:0] result;
    
    // Test counters
    int total_tests = 0;
    int passed_tests = 0;
    int failed_tests = 0;
    string failed_test_names[$];
    
    // Clock period
    localparam CLK_PERIOD = 10ps;
    
    // Instantiate the ALU module
    ALU dut (
        .num(num),
        .clk(clk),
        .rst(rst),
        .segment0(segment0),
        .segment1(segment1),
        .segment2(segment2),
        .segment3(segment3),
        .segment4(segment4),
        .segment5(segment5),
        .carry_out(carry_out)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Task to execute a single test
    task run_test(input [7:0] operand1, input [7:0] operand2, input [3:0] opcode, 
                  input [7:0] expected_result, input expected_carry, input string test_name);
        logic pass;
        
        total_tests++;
        $display("\n--- %s ---", test_name);
        rst = 0;
        #CLK_PERIOD;
        rst = 1;
        
        num = operand1;       // State 00: Load operand1
        #CLK_PERIOD;
        $display("State 00: Loaded operand 1: %d", operand1);
        
        num = operand2;       // State 01: Load operand2
        #CLK_PERIOD;
        $display("State 01: Loaded operand 2: %d", operand2);
        
        num = {opcode};       // State 10: Load opcode
        #CLK_PERIOD;
        $display("State 10: Loaded opcode: 0x%h", opcode);
        
        #CLK_PERIOD;          // State 11: Output state
        $display("State 11: Result: %d, Carry: %b", {dut.y}, carry_out);
        $display("Expected: %d, Carry: %b", expected_result, expected_carry);
        
        // Check if test passed
        if ({dut.y} == expected_result && carry_out == expected_carry) begin
            $display("PASS");
            passed_tests++;
        end else begin
            $display("FAIL");
            failed_tests++;
            failed_test_names.push_back(test_name);
        end
    endtask
    
    // Test stimulus
    initial begin
        int i;

        // Initialize
        num = 8'b0;
        rst = 1;
        #(CLK_PERIOD * 2);
        
        // Run all tests
        run_test(8'd5,   8'd3,   4'b0000, 8'd8,   1'b0, "Test 1: ADD 5 + 3");
        run_test(8'd10,  8'd3,   4'b0001, 8'd7,   1'b0, "Test 2: SUBTRACT 10 - 3");
        run_test(8'd15,  8'd7,   4'b0010, 8'd7,   1'b0, "Test 3: BITWISE AND 15 & 7");
        run_test(8'd11,  8'd6,   4'b0011, 8'd11,  1'b0, "Test 4: OUTPUT A");
        run_test(8'd12,  8'd5,   4'b0101, 8'd9,   1'b0, "Test 5: BITWISE XOR 12 ^ 5");
        run_test(8'd8,   8'd4,   4'b0110, 8'd12,  1'b0, "Test 6: BITWISE OR 8 | 4");
        run_test(8'd255, 8'd1,   4'b0000, 8'd0,   1'b1, "Test 7: ADD 255 + 1 (Overflow)");
        
        // Print summary
        $display("Total Tests:  %d", total_tests);
        $display("Passed:       %d", passed_tests);
        $display("Failed:       %d", failed_tests);
        
        if (failed_tests > 0) begin
            $display("\nFailed Tests:");
            for (i = 0; i < failed_test_names.size(); i++) begin
                $display("  - %s", failed_test_names[i]);
            end
        end
        
        $finish;
    end
    
endmodule
