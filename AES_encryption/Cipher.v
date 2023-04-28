`include "Sbox.v"
`include "ShiftRows.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"
module Cipher #(parameter Nk = 4, parameter Nr = 10)(
                input [127:0] in,
                input [Nk*32 - 1:0] key,
                output reg [127:0] out
);

wire [0:Nr][127:0] start;
wire [0:Nr - 1][127:0] s_box;
wire [0:Nr - 1][127:0] s_row;
wire [0:Nr - 2][127:0] m_col;
wire [0:Nr - 1][Nk*32 - 1:0] k_sch;
wire [0:13][31:0] Rcon = { 
    32'h01000000, 32'h02000000, 32'h04000000, 32'h08000000, 
    32'h10000000, 32'h20000000, 32'h40000000, 32'h80000000, 
    32'h1B000000, 32'h36000000, 32'h6C000000, 32'hD8000000, 
    32'hAB000000, 32'h4D000000
};

AddRoundKey add_key_strt (in, key[Nk*32 - 1 -: 128], start[0]);
KeyExpansion #(Nk) key_exp_strt (key, Rcon[0], k_sch[0]);

genvar i;
generate
    for (i = 0; i < Nr - 1; i = i + 1) begin
        Sbox sbox(start[i], s_box[i]);
        ShiftRows shift_rows(s_box[i], s_row[i]);
        MixColumns mix_col(s_row[i], m_col[i]);
        AddRoundKey add_key (m_col[i], k_sch[i][Nk*32 - 1 -: 128], start[i + 1]);
        KeyExpansion #(Nk) key_exp (k_sch[i], Rcon[i + 1], k_sch[i + 1]);
    end
endgenerate

Sbox sbox(start[Nr - 1], s_box[Nr - 1]);
ShiftRows shift_rows(s_box[Nr - 1], s_row[Nr - 1]);
AddRoundKey add_key_end (s_row[Nr - 1], k_sch[Nr - 1][Nk*32 - 1 -: 128], start[Nr]);

assign out = start[Nr];

endmodule
