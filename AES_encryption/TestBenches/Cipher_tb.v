`include "../Cipher.v"
module Cipher_tb;
    reg [255:0] in ;
    reg [31:0] key;
    wire [255:0] out;
    MixColumnsCipher #(4, 10)  uut(in, key, out);
    initial begin
        $dumpfile("Cipher_tb.vcd");
        $dumpvars(0,Cipher_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'hD4BF5D30E0B452AEB84111F11E2798E5;
        #10
        $finish;
    end
endmodule
//For 128
//3243f6a8885a308d313198a2e0370734
//2b7e151628aed2a6abf7158809cf4f3c
//3925841d02dc09fbdc118597196a0b32