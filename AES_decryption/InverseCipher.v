module InverseCipher (
                input [127:0] in,
                input [128 * (14 + 1) - 1:0] key_out,
                input [1:0] size,
                output [127:0] out
);

wire [127:0] istart [0:14];
wire [127:0] is_box [0:14 - 1];
wire [127:0] is_row [0:14 - 1];
wire [127:0] im_col [0:14 - 1];
wire [127:0] ik_sch1 [0:14];
wire [127:0] ik_sch [0:14];

genvar i;
generate
    for (i = 14; i >= 0; i = i - 1) begin : to_block
        assign ik_sch1[i] = key_out[128 * (i + 1) - 1 -: 128];
    end
endgenerate

assign ik_sch[14] = (size == 2'b01) ? ik_sch1[12] : (size == 2'b00) ? ik_sch1[10] : ik_sch1[14];
assign ik_sch[13] = (size == 2'b01) ? ik_sch1[11] : (size == 2'b00) ? ik_sch1[9] : ik_sch1[13];
assign ik_sch[12] = (size == 2'b01) ? ik_sch1[10] : (size == 2'b00) ? ik_sch1[8] : ik_sch1[12];
assign ik_sch[11] = (size == 2'b01) ? ik_sch1[9] : (size == 2'b00) ? ik_sch1[7] : ik_sch1[11];
assign ik_sch[10] = (size == 2'b01) ? ik_sch1[8] : (size == 2'b00) ? ik_sch1[6] : ik_sch1[10];
assign ik_sch[9] = (size == 2'b01) ? ik_sch1[7] : (size == 2'b00) ? ik_sch1[5] : ik_sch1[9];
assign ik_sch[8] = (size == 2'b01) ? ik_sch1[6] : (size == 2'b00) ? ik_sch1[4] : ik_sch1[8];
assign ik_sch[7] = (size == 2'b01) ? ik_sch1[5] : (size == 2'b00) ? ik_sch1[3] : ik_sch1[7];
assign ik_sch[6] = (size == 2'b01) ? ik_sch1[4] : (size == 2'b00) ? ik_sch1[2] : ik_sch1[6];
assign ik_sch[5] = (size == 2'b01) ? ik_sch1[3] : (size == 2'b00) ? ik_sch1[1] : ik_sch1[5];
assign ik_sch[4] = (size == 2'b01) ? ik_sch1[2] : (size == 2'b00) ? ik_sch1[0] : ik_sch1[4];
assign ik_sch[3] = (size == 2'b01) ? ik_sch1[1] : ik_sch1[3];
assign ik_sch[2] = (size == 2'b01) ? ik_sch1[0] : ik_sch1[2];
assign ik_sch[1] = ik_sch1[1];
assign ik_sch[0] = ik_sch1[0];

InvAddRoundKey inv_add_key_strt (in, ik_sch[14], istart[0]);
assign im_col[0] = istart[0];

generate
    for (i = 0; i < 14; i = i + 1) begin : inv_sim
        if (i != 0) begin
            InvMixColumns inv_mix_col(istart[i], im_col[i]);
        end
        InvShiftRows inv_shift_rows(im_col[i], is_row[i]);
        InvSubBytes inv_sbox(is_row[i], is_box[i]);
        InvAddRoundKey inv_add_key (is_box[i], ik_sch[14 - 1 - i], istart[i + 1]);
    end
endgenerate

assign out = (size == 2'b00) ? istart[10] : (size == 2'b01) ? istart[12] : istart[14];

endmodule
