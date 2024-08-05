module divider_8bit (
    input [7:0] dividend,
    input [7:0] divisor,
    output reg [15:0] result
);

    reg [7:0] quotient;
    reg [7:0] remainder;
    integer i;

    always @(*) begin
        quotient = 8'b0;
        remainder = 8'b0;

        for (i = 7; i >= 0; i = i - 1) begin
            remainder = remainder << 1;
            remainder[0] = dividend[i];
            if (remainder >= divisor) begin
                remainder = remainder - divisor;
                quotient[i] = 1'b1;
            end
        end

        result = {quotient, remainder};
    end
endmodule
