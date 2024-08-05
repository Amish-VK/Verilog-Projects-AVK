module multiplier_8bit (
    input [7:0] A, // 8-bit input operand A
    input [7:0] B, // 8-bit input operand B
    output [15:0] Product // 16-bit output product
);

assign Product = A * B; // Perform the multiplication

endmodule
