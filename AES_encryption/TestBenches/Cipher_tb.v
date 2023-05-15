`include "../Cipher.v"
module Cipher_tb(
    input [127:0] in ,
    input [127:0] key,
    output [0:10][127:0] k_Sch,
    output [127:0] out
);
    Cipher #(4,10) cph(in,key,k_sch,out);
    initial begin
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        #10
        $finish;
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
