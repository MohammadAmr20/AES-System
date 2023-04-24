`include "SubBytes.v"
module SubBytes_tb;
    reg [127:0] in ;
    wire [127:0] out;
    SubBytes uut(in,out);
    initial begin
        $dumpfile("SubBytes_tb.vcd");
        $dumpvars(0,SubBytes_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'h19A09AE93DF4C6F8E3E28D48BE2B2A08;
        #10
        in = 128'hA4686B029C9F5B6A7F35EA50F22B4349;
        // in[4] = 8'h3D;in[5] = 8'hF4;in[6] = 8'hC6;in[7] = 8'hF8;
        // in[8] = 8'hE3;in[9] = 8'hE2;in[10] = 8'h8D;in[11] = 8'h48;
        // in[12] = 8'hBE;in[13] = 8'h2B;in[14] = 8'h2A;in[15] = 8'h08;
        #10
        $finish;
    end
endmodule