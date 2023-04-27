`include "InvSubBytes.v"
module InvSubBytes_tb;
    reg [255:0] in ;
    wire [255:0] out;
    InvSubBytes #(.SIZE(256)) uut(in,out);
    initial begin
        $dumpfile("InvSubBytes_tb.vcd");
        $dumpvars(0,InvSubBytes_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 256'hD4E0B81E27BFB44111985D52AEF1E53049457F77DEDB3902D296875389F11A3B;
        #10
        $finish;
    end
endmodule