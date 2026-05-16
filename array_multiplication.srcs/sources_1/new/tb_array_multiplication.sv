`timescale 1ns / 1ps
module tb_array_multiplication;

    parameter N = 8;

    logic           clk;
    logic           rst_n;
    logic [N-1:0]   a;
    logic [N-1:0]   b;
    logic [2*N-1:0] output_array;

    array_multiplication #(.N(N)) dut (
        .clk         (clk),
        .rst_n       (rst_n),
        .a           (a),
        .b           (b),
        .output_array(output_array)
    );

    always #5 clk = ~clk;  // 10ns period, cleaner to read

    initial begin
        clk   = 0;
        a     = 8'b11011101;  // 221
        b     = 8'b10101110;  // 174
        rst_n = 0;
        @(posedge clk); #1;
        rst_n = 1;

        repeat(N) @(posedge clk);
        #1;

        $display("result:   %0d", output_array);
        $display("expected: %0d", 221*174);

        if (output_array == 221*174)
            $display("PASS");
        else
            $display("FAIL");

        $finish;
    end

endmodule