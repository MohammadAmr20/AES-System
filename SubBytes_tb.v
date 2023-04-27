`include "SubBytes.v"
module SubBytes_tb;
    reg [255:0] in ;
    wire [255:0] out;
    SubBytes #(.SIZE(256)) uut  (in,out);
    initial begin
        $dumpfile("SubBytes_tb.vcd");
        $dumpvars(0,SubBytes_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 256'h19A09AE93DF4C6F8E3E28D48BE2B2A08A4686B029C9F5B6A7F35EA50F22B4349;
        #10
        $finish;
    end
endmodule