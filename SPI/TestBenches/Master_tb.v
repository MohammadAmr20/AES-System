module Master_tb;
    reg clk;
    reg reset;
    reg enable;
    reg [1:0] size;
    wire led1;
    wire led2;
    localparam Period = 10;
    always #(Period/2) clk = ~clk;
    Master master(clk, reset,enable, size, led1, led2);
    initial begin
        $display ("time\t\t\t\t\t\t output");
        $monitor ("%g\t\t\t %h",$time,led1);
        clk = 1'b0;
	#100
        reset = 1'b1;
        size = 2'b00;
	enable = 1'b1;
        #1000
        reset = 1'b0;
        #395000
        reset = 1'b1;
        size = 2'b01;
        #1000
        reset = 1'b0;
        #460000
        reset = 1'b1;
        size = 2'b10;
        #1000
        reset = 1'b0;
        #535000
        $finish;
end
    
endmodule
