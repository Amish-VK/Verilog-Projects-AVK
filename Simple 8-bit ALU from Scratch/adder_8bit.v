`include "full_adder.v"

module adder_8bit (
    input wire [7:0] A,    
    input wire [7:0] B,   
    input wire Cin,        
    output wire [7:0] Sum, 
    output wire Cout,      
    output wire Overflow,
    output wire AuxCarry  
);

    wire [7:0] carry; 

    genvar i;

    generate
        for (i = 0; i < 8; i = i + 1) begin : adder
            if (i == 0) 
            begin
                full_adder fa (
                    .A(A[i]), 
                    .B(B[i]), 
                    .Cin(Cin), 
                    .Sum(Sum[i]), 
                    .Cout(carry[i])
                );
            end 
            else 
            begin
                full_adder fa (
                    .A(A[i]), 
                    .B(B[i]), 
                    .Cin(carry[i-1]), 
                    .Sum(Sum[i]), 
                    .Cout(carry[i])
                );
            end
        end
    endgenerate

    assign Cout = carry[7]; 
    assign Overflow = carry[7] ^ carry[6]; 
    assign AuxCarry = carry[3]; 

endmodule
