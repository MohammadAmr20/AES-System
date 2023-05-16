`include "../InvSubBytes.v"
module InvSubBytes_tb;
    reg [127:0] in ;
    wire [127:0] out;
    InvSubBytes  uut(in,out);
    initial begin
        $dumpfile("InvSubBytes_tb.vcd");
        $dumpvars(0,InvSubBytes_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'hD4E0B81E27BFB44111985D52AEF1E530;
        #10
        $finish;
    end
endmodule