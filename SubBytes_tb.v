`include "SubBytes.v"
module SubBytes_tb;
    reg [127:0] in ;
    wire [127:0] out;
    SubBytes  uut  (in,out);
    initial begin
        $dumpfile("SubBytes_tb.vcd");
        $dumpvars(0,SubBytes_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'h19A09AE93DF4C6F8E3E28D48BE2B2A08;
        #10
        $finish;
    end
endmodule