`include "../Slave.v"
module Slave_tb;
    reg [127:0] msg;
    reg [255:0] key;
    reg [1:0] size;
    reg mode;
    reg reset;
    wire SOMI;
    reg SIMO;
    reg clk;
    reg CSS;
    integer i;
    localparam Period = 10;
    always #(Period/2) clk = ~clk;
    Slave slave(clk, reset, SIMO, CSS, mode, size, SOMI);
    initial begin
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,msg,SOMI);
        clk = 1'b0;
        mode = 1'b0;
        CSS = 1'b0;
        size = 2'b01;
        msg = 128'h3243f6a8885a308d313198a2e0370734;
        key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        i = 0;
        reset = 1'b1;
        #10
        reset = 1'b0;
    end
    always @(posedge clk)  begin
        if (i < 128) begin
            SIMO = msg[i];
            i = i + 1;
        end
        else if (i < (128 + 32 * 8)) begin
            SIMO = key[i - 128];
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

//For 128
//3243f6a8885a308d313198a2e0370734
//2b7e151628aed2a6abf7158809cf4f3c
//3925841d02dc09fbdc118597196a0b32

//For 192
//00112233445566778899aabbccddeeff
//000102030405060708090a0b0c0d0e0f1011121314151617
//dda97ca4864cdfe06eaf70a0ec0d7191

//For 256
//00112233445566778899aabbccddeeff
//000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f
//8ea2b7ca516745bfeafc49904b496089
