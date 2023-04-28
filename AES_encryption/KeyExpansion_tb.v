`include "KeyExpansion.v"
module KeyExpansion_tb;
    reg [127:0] in ;
    reg [31:0] key;
    wire [127:0] out;
    KeyExpansion  uut(in,key,out);
    initial begin
        $dumpfile("KeyExpansion_tb.vcd");
        $dumpvars(0,KeyExpansion_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'h2B7E151628AED2A6ABF7158809CF4F3C;
        key = 32'h01000000;
        #10
        $finish;
    end
endmodule
//2b7e151628aed2a6abf7158809cf4f3c
//a0fafe1788542cb123a339392a6c7605
//01000000
