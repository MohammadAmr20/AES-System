module Cipher (
                input [127:0] in,
                input [255:0] key,
                input [1:0] size,
                output [128 * (14 + 1) - 1:0] key_out,
                output [127:0] out
);

wire [127:0] start [0:14];
wire [127:0] encrypt [0:2];
wire [127:0] s_box [0:14 - 1];
wire [127:0] s_row [0:14 - 1];
wire [127:0] m_col [0:14 - 1];
wire [127:0] k_sch [0:14];
wire [4*32*11 - 1:0] keys1;
wire [6*32*11 - 1:0] keys2;
wire [8*32*11 - 1:0] keys3;
wire [128 * (14 + 1) - 1:0] key_o;
wire [31:0] Rcon  [0:9];
assign Rcon[0] = 32'h01000000;
assign Rcon[1] = 32'h02000000;
assign Rcon[2] = 32'h04000000;
assign Rcon[3] = 32'h08000000;
assign Rcon[4] = 32'h10000000;
assign Rcon[5] = 32'h20000000;
assign Rcon[6] = 32'h40000000;
assign Rcon[7] = 32'h80000000;
assign Rcon[8] = 32'h1B000000;
assign Rcon[9] = 32'h36000000;


AddRoundKey add_key_strt (in, key[255 -: 128], start[0]);
assign keys1[4*32*11 - 1 -: 4*32] = key[255 -: 128];
assign keys2[6*32*11 - 1 -: 6*32] = key[255 -: 192];
assign keys3[8*32*11 - 1 -: 8*32] = key;

genvar i;
generate
    for (i = 0; i < 10; i = i + 1) begin : exp1
        KeyExpansion #(4) key_exp1 (keys1[4*32*(11 - i) - 1 -: 4*32], Rcon[i][31:0], keys1[4*32*(10 - i) - 1 -: 4*32]);
    end
    for (i = 0; i < 8; i = i + 1) begin : exp2
        KeyExpansion #(6) key_exp2 (keys2[6*32*(11 - i) - 1 -: 6*32], Rcon[i][31:0], keys2[6*32*(10 - i) - 1 -: 6*32]);
    end
    for (i = 0; i < 7; i = i + 1) begin : exp3
        KeyExpansion #(8) key_exp3 (keys3[8*32*(11 - i) - 1 -: 8*32], Rcon[i][31:0], keys3[8*32*(10 - i) - 1 -: 8*32]);
    end
    for (i = 0; i <= 14; i = i + 1) begin : to_block
        assign k_sch[i] = (size == 2'b00 && i < 11) ? keys1[4*32*11 - 1 - 128*i -: 128] : (size == 2'b01 && i < 13) ? keys2[6*32*11 - 1 - 128*i -: 128] : keys3[8*32*11 - 1 - 128*i -: 128];
    end


    for (i = 0; i < 14 - 1; i = i + 1) begin : sim
        SubBytes sbox(start[i], s_box[i]);
        ShiftRows shift_rows(s_box[i], s_row[i]);
        MixColumns mix_col(s_row[i], m_col[i]);
        AddRoundKey add_key (m_col[i], k_sch[i + 1], start[i + 1]);
    end
endgenerate


AddRoundKey add_key_end1 (s_row[9], k_sch[10], encrypt[0]);

AddRoundKey add_key_end2 (s_row[11], k_sch[12], encrypt[1]);

SubBytes sbox3(start[13], s_box[13]);
ShiftRows shift_rows3(s_box[13], s_row[13]);
AddRoundKey add_key_end3 (s_row[13], k_sch[14], encrypt[2]);

generate
    for (i = 0; i <= 14; i = i + 1) begin : to_line
       assign key_o [(128 *(14 + 1 - i) - 1) -: 128] = k_sch[14 - i];
    end
endgenerate

assign out = (size == 2'b00) ? encrypt[0] : (size == 2'b01) ? encrypt[1] : encrypt[2];
assign key_out = key_o;

endmodule
