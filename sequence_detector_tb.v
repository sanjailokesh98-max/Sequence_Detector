
`timescale 1ns/1ps

module tb_sequence_detector;

    reg clk;
    reg rst;
    reg din;
    wire dout;

    
    sequence_detector uut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    
    always #5 clk = ~clk;

    
    initial begin

        clk = 0;
        rst = 1;
        din = 0;

        
        #10;
        rst = 0;

    	@(negedge clk) din = 1;
        @(negedge clk) din = 0;
        @(negedge clk) din = 1;
        @(negedge clk) din = 1;
        @(negedge clk) din = 0;

        
        @(negedge clk) din = 1;
        @(negedge clk) din = 0;
        @(negedge clk) din = 1;
        @(negedge clk) din = 1;
        @(negedge clk) din = 0;

    
        @(negedge clk);
        $finish;

    end

    
    initial begin
        $monitor("Time=%0t | Reset=%b | Input=%b | Output=%b",
                  $time, rst, din, dout);
    end

endmodule
