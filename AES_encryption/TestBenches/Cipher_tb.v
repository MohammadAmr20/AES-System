module Cipher_tb;

   reg [127:0] in ;
   reg [1:0] size;
   reg [255:0] key;
   reg [127:0] key1;
   wire [128 * (14 + 1) - 1:0] key_out;
   wire [127:0] out;


    Cipher cph(in,key, size, key_out,out);
    initial begin
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
	in= 128'h3243f6a8885a308d313198a2e0370734;
	key1= 128'h2b7e151628aed2a6abf7158809cf4f3c;
    key[255 -: 128] = key1;
    size = 2'b00;
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
