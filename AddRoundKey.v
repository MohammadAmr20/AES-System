
module AddRoundKey(
input [127:0]datain1,
input [127:0]datain2,
output [127:0]dataout
);


assign dataout = datain1 ^ datain2;

endmodule
