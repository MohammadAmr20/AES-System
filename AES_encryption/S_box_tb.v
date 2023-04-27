`include "S_box.v"
module S_box_tb;
    reg [7:0] in ;
    wire [7:0] out;
    S_box uut(in,out);
    initial begin
        $display ("time\t input \t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        $dumpfile("Sbox_tb.vcd");
        $dumpvars(0,Sbox_tb);
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