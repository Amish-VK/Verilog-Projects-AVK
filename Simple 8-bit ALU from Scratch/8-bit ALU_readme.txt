A Simple 8-bit ALU implementation in verilog.
Functionality : OPCODE 
    * Negation        : 0000_<8-bit Operand>_<8-bit Operand>
    * Addition        : 0001_<8-bit Operand>_<8-bit Operand>
    * Subtraction     : 0010_<8-bit Operand>_<8-bit Operand>
    * Multiplication  : 0011_<8-bit Operand>_<8-bit Operand>
    * Division        : 0100_<8-bit Operand>_<8-bit Operand>
    * AND             : 0101_<8-bit Operand>_<8-bit Operand>
    * OR              : 0110_<8-bit Operand>_<8-bit Operand>
    * XOR             : 0111_<8-bit Operand>_<8-bit Operand>

alu.v : The top module for the ALU
alu_tb.v : Sample Testbench fpr simulation and verification

