`include "Sbox.v"

module KeyExpansion #(parameter Nk = 4)(
        input [Nk*32 - 1:0] Keyprev,
        input [31:0] Rcon,
        output [Nk*32 - 1:0] Keynext
);

wire [31:0] temp;

Sbox last_col({96'h0, Keyprev[31:0]}, {96'h0, temp[23:0], temp[31:24]});

assign Keynext[(Nk*32 - 1) -: 32] = Keyprev[(Nk*32 - 1) -: 32] ^ temp ^ Rcon;

genvar i;
generate
    for (i = (Nk - 1)*32 - 1; i >= 0; i = i - 32) begin
        assign Keynext[i-:32] = Keynext[i + 32 -:32] ^ Keyprev[i-:32];
    end
endgenerate

endmodule
