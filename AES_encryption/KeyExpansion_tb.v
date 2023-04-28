`include "KeyExpansion.v"
module KeyExpansion_tb;
    reg [255:0] in ;
    reg [31:0] key;
    wire [255:0] out;
    KeyExpansion #(8) uut(in,key,out);
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

//For 192
//8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b
//fe0c91f72402f5a5ec12068e6c827f6b0e7a95b95c56fec2
//01000000

//For 256
//603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4
//9ba354118e6925afa51a8b5f2067fcdea8b09c1a93d194cdbe49846eb75d5b9a
//01000000