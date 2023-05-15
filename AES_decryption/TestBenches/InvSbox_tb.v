`include "../InvSbox.v"
module InvSbox_tb;
    reg [7:0] in ;
    wire [7:0] out;
    InvSbox uut(in,out);
    initial begin
        $display ("time\t input \t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        $dumpfile("InvSbox_tb.vcd");
        $dumpvars(0,InvSbox_tb);
        in = 8'h00;
        #1
        in = 8'h23;
        #1
        in = 8'h56;
        #1
        in = 8'hA3;
        #1
        in = 8'h4E;
        #1
        in = 8'h19;
        #1
        in = 8'hFF;
        #1
        in = 8'hCC;
        #1
        in = 8'hDF;
        #10
        $finish;
    end
endmodule