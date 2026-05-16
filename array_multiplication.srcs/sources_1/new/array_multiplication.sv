`timescale 1ns / 1ps

module array_multiplication #(
    parameter N = 8 // bit width
    )
(
 input logic           clk,
 input logic           rst_n,
 input logic [(N-1):0] a,
 input logic [(N-1):0] b,
 
 output logic[2*N-1:0] output_array
);
logic [$clog2(N)-1:0] n;

always_ff @(posedge clk or negedge rst_n)begin
if (!rst_n) begin
        n            <= '0;
        output_array <= '0;
    end 
    else if (n<N) begin
        n <= n + 1'b1;

        output_array <= output_array + (a << n) * b[n];
    end
end

endmodule
