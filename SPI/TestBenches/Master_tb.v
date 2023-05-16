module Master_tb;
    reg clk;
    reg reset;
    reg enable;
    wire led1;
    wire led2;
    localparam Period = 10;
    always #(Period/2) clk = ~clk;
    Master master(clk, reset,enable, led1, led2);
    initial begin
        $display ("time\t\t\t\t\t\t output");
        $monitor ("%g\t\t\t %h",$time,led1);
        clk = 1'b0;
	#100
        reset = 1'b1;
	enable = 1'b1;
        #1000
        reset = 1'b0;
end
    
endmodule
