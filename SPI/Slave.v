`include "../AES_encryption/Cipher.v"
module Slave #(parameter Nk = 4, parameter Nr = 10)(
                input clk,
                input SIMO,
                input mode,
                output reg [127:0] out,
                output reg SOMI                
);
reg [127:0] msg;
reg [Nk*32 - 1:0] key;
wire [1:0] done;
integer i = 0;

wire [127:0] encrypt;
wire [0:Nr][127:0] k_sch;
wire [127:0] decrypt;

parameter encr = 1'b0;
parameter decr = 1'b1;
always @(posedge clk) begin
  if (mode == encr) begin
    if (i < 128) begin
      msg <= {SIMO, msg[127:1]};
      i <= i + 1;
    end
    else if (i < 127 + Nk*32) begin
      key <= {SIMO, key[Nk*32 - 1:1]};
      i <= i + 1;
    end
    else begin
      SOMI <= encrypt[i - 128 + Nk*32];
      i <= i + 1;
    end
  end
end

assign done = (i >= 127 + Nk*32) ? 2'b01 : 2'b00;
Cipher #(Nk, Nr) cipher (msg, key, k_sch, encrypt);
assign out = encrypt;

endmodule
