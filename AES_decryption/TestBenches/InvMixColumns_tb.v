`include "../InvMixColumns.v"
module InvMixColumns_tb();
    reg [127:0] in ;
    wire [127:0] out;
    InvMixColumns  uut(in,out);
    initial begin
        $dumpfile("InvMixColumns_tb.vcd");
        $dumpvars(0,InvMixColumns_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'h046681E5E0CB199A48F8D37A2806264C;
        #10
        $finish;
    end
endmodule
//D4BF5D30E0B452AEB84111F11E2798E5