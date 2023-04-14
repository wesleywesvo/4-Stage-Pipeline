Files for the testbench and what the testbench does

Input file: instr_binary.txt

Output files that will be generated:
output.txt - Contains values in binary of each instruction/register and some signals during each cycle 
(may contain some bugs for the ALU inputs however - some cycles the inputs are a values that are a cycle earlier)

register_output.txt - Values of the corresponding registers as they are being written back into the Register File unit (written in hex)