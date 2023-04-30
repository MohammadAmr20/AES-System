`include "Sbox.v"
`include "ShiftRows.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"
module Cipher #(parameter Nk = 4, parameter Nr = 10)(
                input [127:0] in,
                input [Nk*32 - 1:0] key,
                output [0:Nr][127:0] k_sch,
                output reg [127:0] out
);

wire [0:Nr][127:0] start;
wire [0:Nr - 1][127:0] s_box;
wire [0:Nr - 1][127:0] s_row;
wire [0:Nr - 2][127:0] m_col;
wire [Nk*32*11 - 1:0] keys;
wire [0:9][31:0] Rcon = { 
    32'h01000000, 32'h02000000, 32'h04000000, 32'h08000000, 
    32'h10000000, 32'h20000000, 32'h40000000, 32'h80000000, 
    32'h1B000000, 32'h36000000
};

AddRoundKey add_key_strt (in, key[Nk*32 - 1 -: 128], start[0]);
assign keys[Nk*32*11 - 1 -: Nk*32] = key;

genvar i;
generate
    for (i = 0; i < 10; i = i + 1) begin
        KeyExpansion #(Nk) key_exp (keys[Nk*32*(11 - i) - 1 -: Nk*32], Rcon[i], keys[Nk*32*(10 - i) - 1 -: Nk*32]);
    end
    for (i = 0; i <= Nr; i = i + 1) begin
        assign k_sch[i] = keys[Nk*32*11 - 1 - 128*i -: 128];
    end
    for (i = 0; i < Nr - 1; i = i + 1) begin
        Sbox sbox(start[i], s_box[i]);
        ShiftRows shift_rows(s_box[i], s_row[i]);
        MixColumns mix_col(s_row[i], m_col[i]);
        AddRoundKey add_key (m_col[i], k_sch[i + 1], start[i + 1]);
    end
endgenerate

Sbox sbox(start[Nr - 1], s_box[Nr - 1]);
ShiftRows shift_rows(s_box[Nr - 1], s_row[Nr - 1]);
AddRoundKey add_key_end (s_row[Nr - 1], k_sch[Nr], start[Nr]);

assign out = start[Nr];

endmodule
