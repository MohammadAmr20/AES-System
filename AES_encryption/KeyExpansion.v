module KeyExpansion #(parameter Nk = 4)(
        input [Nk*32 - 1:0] Keyprev,
        input [31:0] Rcon,
        output [Nk*32 - 1:0] Keyfinal
);

wire [31:0] temp;
wire [Nk*32 - 1:0] Keynext;
wire [127:0] in = {96'h0, Keyprev[31:0]};
wire [127:0] out, in2, out2;
SubBytes last_col(in , out);

assign temp = {out[23:0], out[31:24]};

parameter last_column = Nk*32 - 1;
assign Keynext[last_column -: 32] = Keyprev[last_column -: 32] ^ temp ^ Rcon;

parameter nk = Nk;
genvar i;
generate
    for (i = (nk - 1)*32 - 1; i >= 0; i = i - 32) begin : exp
        if (nk == 8 && i == 4*32 - 1) begin
            assign in2 = {96'h0, Keynext[i + 32 -:32]};
            SubBytes mid_col(in2 , out2);
            assign Keynext[i-:32] = out2[31:0] ^ Keyprev[i-:32];
        end
        else begin
            assign Keynext[i-:32] = Keynext[i + 32 -:32] ^ Keyprev[i-:32];
        end
    end
endgenerate

assign Keyfinal = Keynext;

endmodule
