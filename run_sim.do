# do file
# Anthony Nguyen
# 5/24
# sources: .do files from lab 5

# Compile all SystemVerilog source files
vlog -sv Addition.sv
vlog -sv Subtraction.sv
vlog -sv Multiplication.sv
vlog -sv Modulo.sv
vlog -sv Bitwise_AND.sv
vlog -sv Bitwise_OR.sv
vlog -sv Bitwise_XOR.sv
vlog -sv Output_Operand.sv
vlog -sv Register.sv
vlog -sv SevenSegmentDecode.sv
vlog -sv ALU.sv
vlog -sv ALU_tb.sv
vlog -sv Display.sv
vlog -sv Opcode_decode.sv

# Simulate the testbench
vsim ALU_tb

# Add waveforms with labels
add wave -label "Clock" /ALU_tb/clk
add wave -label "Reset" /ALU_tb/rst
add wave -label "Input Number" /ALU_tb/num
add wave -label "State" /ALU_tb/dut/state
add wave -label "Operand 1" /ALU_tb/dut/reg1
add wave -label "Operand 2" /ALU_tb/dut/reg2
add wave -label "Opcode" /ALU_tb/dut/opcode
add wave -label "ALU Result" /ALU_tb/dut/y
add wave -label "Carry Out" /ALU_tb/carry_out
add wave -divider "Seven Segment Displays"
add wave -label "Segment 0" /ALU_tb/segment0
add wave -label "Segment 1" /ALU_tb/segment1
add wave -label "Segment 2" /ALU_tb/segment2
add wave -label "Segment 3" /ALU_tb/segment3
add wave -label "Segment 4" /ALU_tb/segment4
add wave -label "Segment 5" /ALU_tb/segment5

# Run the simulation
run -all


