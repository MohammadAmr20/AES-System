`include "../Slave.v"
module Slave_tb;
    reg [127:0] msg;
    reg [127:0] key;
    reg mode;
    wire SOMI;
    reg SIMO;
    reg clk;
    integer i;
    localparam Period = 10;
    always #(Period/2) clk = ~clk;
    Slave #(4, 10) slave(clk, SIMO, mode, SOMI);
    initial begin
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,msg,SOMI);
        clk = 1'b0;
        mode = 1'b0;
        msg = 128'h3243f6a8885a308d313198a2e0370734;
        key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        i = 0;
    end
    always @(posedge clk)  begin
        if (i < 129) begin
            SIMO = msg[i];
            i = i + 1;
        end
        else if (i < (130 + 32 * 4)) begin
            SIMO = key[i - 129];
            i = i + 1;
        end
	else begin
	#10
        mode=1'b1;
        #1000000
	$finish;
	end
    end
endmodule
