`include "adder_8bit.v"
`include "multiplier_8bit.v"
`include "divider_8bit.v"

module alu(
    input [19:0] in,
    input clk,
    output reg [15:0] out,
    output reg [7:0] flag
);

    wire [7:0] adder_sum,adder_diff,neg_input;
    wire adder_cout,adder_borrow, adder_overflow,adder_sub_overflow, adder_auxcarry,adder_sub_auxcarry;
    wire [15:0] mul_product,div_ans;

    reg [15:0] not_out,and_out,or_out,xor_out,add_out,sub_out, mul_out,div_out;
    reg [7:0] not_flags,and_flags,or_flags,xor_flags,add_flags, sub_flags, mul_flags,div_flags;

        adder_8bit ad (
            .A(in[15:8]),    
            .B(in[7:0]),   
            .Cin(1'b0),        
            .Sum(adder_sum), 
            .Cout(adder_cout),
            .Overflow(adder_overflow),
            .AuxCarry(adder_auxcarry)
        );
        assign neg_input=(~in[7:0])+1;
        adder_8bit sub (
            .A(in[15:8]),    
            .B(neg_input),   
            .Cin(1'b0),        
            .Sum(adder_diff), 
            .Cout(adder_borrow),
            .Overflow(adder_sub_overflow),
            .AuxCarry(adder_sub_auxcarry)
        );

        multiplier_8bit mul(
            .A(in[15:8]),
            .B(in[7:0]),
            .Product(mul_product)
        );

        divider_8bit div(
            .dividend(in[15:8]),
            .divisor(in[7:0]),
            .result(div_ans)
        );

    always@(*)
        begin
            //even party in parity bit
            //result=quotient_remainder
            /*0000 Negation
              0001 Addition
              0010 Subtraction
              0011 Multiplication
              0100 Division
              0101 AND
              0110 OR
              0111 XOR
            */
        case(in[19:16])
            4'b0000:    begin
                            not_out={~in[15:8], ~in[7:0]};
                            not_flags={4'b0000,((not_out==8'd0)?1'b1:1'b0),1'b0,((^not_out)?1'b0:1'b1),1'b0};
                        end

            4'b0001:    begin
                            add_out={8'd0,adder_sum};
                            add_flags={2'b00,adder_overflow,(adder_sum[7]?1'b1:1'b0),((adder_sum==8'd0)?1'b1:1'b0),(adder_auxcarry?1'b1:1'b0),((^adder_sum)?1'b0:1'b1),adder_cout};
                        end

            4'b0010:    begin
                            sub_out=adder_diff;
                            sub_flags={2'b00,adder_sub_overflow,(adder_diff[7]?1'b1:1'b0),((adder_diff==8'd0)?1'b1:1'b0),(adder_sub_auxcarry?1'b1:1'b0),((^adder_diff)?1'b0:1'b1),adder_borrow};
                        end

            4'b0011:    begin
                            mul_out=mul_product;
                            mul_flags={3'b000,(mul_product[15]?1'b1:1'b0),((mul_product==8'd0)?1'b1:1'b0),1'b0,((^mul_product)?1'b0:1'b1),1'b0};
                        end

            4'b0100:    begin
                            div_out=div_ans;
                            div_flags={4'b0000,((div_ans==8'd0)?1'b1:1'b0),1'b0,((^div_ans)?1'b0:1'b1),1'b0};
                        end
            
            4'b0101:    begin
                            and_out={8'd0,in[15:8]&in[7:0]};
                            and_flags={4'b0000,((and_out==8'd0)?1'b1:1'b0),1'b0,((^and_out)?1'b0:1'b1),1'b0};
                        end

            4'b0110:    begin
                            or_out={8'd0,in[15:8]|in[7:0]};
                            or_flags={4'b0000,((or_out==8'd0)?1'b1:1'b0),1'b0,((^or_out)?1'b0:1'b1),1'b0};
                        end  

            4'b0111:    begin
                            xor_out={8'd0,in[15:8]^in[7:0]};
                            xor_flags={4'b0000,((xor_out==8'd0)?1'b1:1'b0),1'b0,((^xor_out)?1'b0:1'b1),1'b0};
                        end  
                      
        endcase
        end

    always @(posedge clk) begin

        case(in[19:16])
            4'b0000:    begin
                            out <= not_out;
                            flag <= not_flags; 
                        end

            4'b0001:    begin
                            out <= add_out;
                            flag<= add_flags; 
                        end

            4'b0010:    begin
                            out <= sub_out; 
                            flag <= sub_flags ; 
                        end

            4'b0011:    begin
                            out <= mul_out; 
                            flag <= mul_flags ; 
                        end

            4'b0100:    begin
                            out <= div_out; 
                            flag <= div_flags; 
                        end
        
            4'b0101:    begin
                            out <= and_out; 
                            flag <= and_flags; 
                        end

            4'b0110:    begin
                            out <= or_out; 
                            flag <= or_flags; 
                        end  

            4'b0111:    begin
                            out <= xor_out; 
                            flag <= xor_flags; 
                        end  
    endcase

end

endmodule