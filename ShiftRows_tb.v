`include "ShiftRows.v"
module ShiftRows_tb;
    reg [127:0] in ;
    wire [127:0] out;
    ShiftRows  uut(in,out);
    initial begin
        $dumpfile("ShiftRows_tb.vcd");
        $dumpvars(0,ShiftRows_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'hD42711AEE0BF98F1B8B45DE51E415230;
        #10
        $finish;
    end
endmodule