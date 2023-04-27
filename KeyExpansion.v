`include "Sbox.v"

module KeyExpansion(
input [127:0]datain,
input [31:0]cuurentkey,
output [127:0]dataout
);

wire [31:0]temp;

genvar i;
generate 
for(i=23;i>=0;i=i-8)begin
Sbox sb1(datain[i:i-7],temp[i+8:i+1]);
end
endgenerate

Sbox sb2(datain[31:24],temp[7:0]);

assign dataout[127:96] = datain[127:96] ^ temp ^ cuurentkey;

assign dataout[95:64] = dataout[127:96] ^ datain[95:64];
assign dataout[63:32] = dataout[95:64] ^ datain[63:32];
assign dataout[31:0] = dataout[63:32] ^ datain[31:0];

endmodule
