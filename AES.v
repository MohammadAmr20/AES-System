`include "AES_encryption/Cipher.v"
`include "AES_decryption/InverseCipher.v"
module AES #(parameter Nk = 4, parameter Nr = 10) (
            input [127:0] in,
            input [Nk*32 - 1 : 0] key,
            output reg [127:0] out
);
wire [127:0] encrypt;
wire [0:Nr][127:0] k_sch;
wire [127:0] decrypt;

Cipher #(Nk, Nr) cipher (in, key, k_sch, encrypt);

InverseCipher #(Nk, Nr) inv_cipher (encrypt, k_sch, decrypt);

assign out = decrypt;

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
