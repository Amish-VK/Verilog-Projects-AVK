`timescale 1ns/1ps
`include "alu.v"

module alu_tb();
    reg [19:0] in;
    reg clk;
    wire [15:0] out;
    wire [7:0] flag;

    // Clock with a time period of 4ns
    initial begin
        clk = 1'b0;
        forever #2 clk = ~clk;
    end

    // Instantiating the ALU
    alu alu1(
        .in(in),
        .clk(clk),
        .out(out),
        .flag(flag)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // Negation
        in = 20'b0000_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: Negation | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // Addition
        in = 20'b0001_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: Addition | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // Subtraction
        in = 20'b0010_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: Subtraction | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // Multiplication
        in = 20'b0011_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: Multiplication | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // Division
        in = 20'b0100_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: Division | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // AND
        in = 20'b0101_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: AND | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // OR
        in = 20'b0110_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: OR | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        // XOR
        in = 20'b0111_0011_0010_0010_1101; 
        $monitor("Time: %t | Operation: XOR | A: %d | B: %d | out: %d | flag: %b", 
                 $time, in[15:8], in[7:0], out, flag);
        #10;

        $finish;
    end
endmodule
