`include "../../Modules/SubBytes.v"
module SubBytes_tb;
    reg [7:0] in [0:3];
    wire [7:0] out [0:3];
    SubBytes uut(in,out);
    initial begin
        $display ("time\t input0 \t output3");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        $dumpfile("SubBytes_tb.vcd");
        $dumpvars(0,SubBytes_tb);
        in[0] = 8'h19;in[1] = 8'hA0;in[2] = 8'h9A;in[3] = 8'hE9;
        // in[4] = 8'h3D;in[5] = 8'hF4;in[6] = 8'hC6;in[7] = 8'hF8;
        // in[8] = 8'hE3;in[9] = 8'hE2;in[10] = 8'h8D;in[11] = 8'h48;
        // in[12] = 8'hBE;in[13] = 8'h2B;in[14] = 8'h2A;in[15] = 8'h08;
        #10
        $finish;
    end
endmodule