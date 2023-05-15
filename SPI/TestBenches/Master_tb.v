`include "../Master.v"
module Master_tb;
    reg clk;
    reg reset;
    wire led;
    localparam Period = 10;
    always #(Period/2) clk = ~clk;
    Master master(clk, reset, led);
    initial begin
        $display ("time\t\t\t\t\t\t output");
        $monitor ("%g\t\t\t %h",$time,led);
        clk = 1'b0;
        reset = 1'b1;
        #1000
        reset = 1'b0;
    end
    
endmodule
