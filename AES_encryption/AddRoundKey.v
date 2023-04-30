
module AddRoundKey (
    input [127:0] datain,
    input [127:0] key,
    output [127:0] dataout
);


assign dataout = datain ^ key;

endmodule
