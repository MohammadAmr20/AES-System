`include "../AddRoundKey.v"
module AddRoundKey_tb();
    reg [127:0] in1,in2 ;
    wire [127:0] out;
    AddRoundKey  uut(in1,in2,out);
    initial begin
        $dumpfile("AddRoundKey_tb.vcd");
        $dumpvars(0,AddRoundKey_tb);
        $display ("time\t input1 \t\t\t\t\t\t\t\t input2 \t\t\t\t\t\t\t\t output");
        $monitor ("%g\t %h\t\t %h\t\t %h",$time,in1,in2,out);
        in1 = 128'h046681E5E0CB199A48F8D37A2806264C;
        in2 = 128'hD4BF5D30E0B452AEB84111F11E2798E5;
        #10
        $finish;
    end
endmodule
//d0d9dcd5007f4b34f0b9c28b3621bea9