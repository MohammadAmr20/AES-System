module SubBytes_tb;
    reg [127:0] in ;
    wire [127:0] out;
    SubBytes  uut(in,out);
    initial begin
        $dumpfile("SubBytes_tb.vcd");
        $dumpvars(0,SubBytes_tb);
        $display ("time\t input \t\t\t\t\t\t\t\t  output");
        $monitor ("%g\t %h\t\t %h",$time,in,out);
        in = 128'h193DE3BEA0F4E22B9AC68D2AE9F84808;
        #10
        $finish;
    end
endmodule
//D42711AEE0BF98F1B8B45DE51E415230