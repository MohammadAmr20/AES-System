`include "../Master.v"
module Master_tb;
    reg clk;
    reg reset;
    reg enable;
    wire led_dec;
    wire led_fin;
    localparam Period = 10;
    always #(Period/2) clk = ~clk;
    Master master(clk, reset,enable, led_dec,led_fin);
    initial begin
        $display ("time\t\t\t\t\t\t output");
        $monitor ("%g\t\t\t %h",$time,led_dec);
        clk = 1'b0;
	#100
        reset = 1'b1;
	enable = 1'b1;
        #3000
        reset = 1'b0;
end
    
endmodule
