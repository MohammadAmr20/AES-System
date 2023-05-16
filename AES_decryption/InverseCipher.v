module InverseCipher #(parameter Nk = 4, parameter Nr = 10)(
                input [127:0] in,
                input [128 * (Nr + 1) - 1:0] key_out,
                input [1:0] size,
                output [127:0] out
);

wire [127:0] istart [0:Nr];
wire [127:0] is_box [0:Nr - 1];
wire [127:0] is_row [0:Nr - 1];
wire [127:0] im_col [0:Nr - 1];
wire [127:0] ik_sch [0:Nr];

genvar i;
generate
    for (i = Nr; i >= 0; i = i - 1) begin : to_block
        assign ik_sch[i] = key_out[128 * (i + 1) - 1 -: 128];
    end
endgenerate

InvAddRoundKey inv_add_key_strt (in, ik_sch[Nr], istart[0]);
assign im_col[0] = istart[0];

generate
    for (i = 0; i < Nr; i = i + 1) begin : inv_sim
        if (i != 0) begin
            InvMixColumns inv_mix_col(istart[i], im_col[i]);
        end
        InvShiftRows inv_shift_rows(im_col[i], is_row[i]);
        InvSubBytes inv_sbox(is_row[i], is_box[i]);
        InvAddRoundKey inv_add_key (is_box[i], ik_sch[Nr - 1 - i], istart[i + 1]);
    end
endgenerate

assign out = istart[Nr];

endmodule
