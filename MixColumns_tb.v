`include "MixColumns.v"
module MixColumns_tb;
    reg [127:0] in ;
    wire [127:0] out;
    MixColumns  uut(in,out);
    initial begin
        $dumpfile("MixColumns_tb.vcd");
        $dumpvars(0,MixColumns_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'hD4BF5D30E0B452AEB84111F11E2798E5;
        #10
        $finish;
    end
endmodule