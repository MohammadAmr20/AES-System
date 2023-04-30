`include "InvSbox.v"
`include "InvShiftRows.v"
`include "InvMixColumns.v"
`include "InvAddRoundKey.v"
module InverseCipher #(parameter Nk = 4, parameter Nr = 10)(
                input [127:0] in,
                input [0:Nr][127:0] ik_sch,
                output reg [127:0] out
);

wire [0:Nr][127:0] istart;
wire [0:Nr - 1][127:0] is_box;
wire [0:Nr - 1][127:0] is_row;
wire [0:Nr - 1][127:0] im_col;

InvAddRoundKey inv_add_key_strt (in, ik_sch[Nr], istart[0]);
assign im_col[0] = istart[0];

genvar i;
generate
    for (i = 0; i < Nr; i = i + 1) begin
        if (i != 0) begin
            InvMixColumns inv_mix_col(istart[i], im_col[i]);
        end
        InvShiftRows inv_shift_rows(im_col[i], is_row[i]);
        InvSbox inv_sbox(is_row[i], is_box[i]);
        InvAddRoundKey inv_add_key (is_box[i], ik_sch[Nr - 1 - i], istart[i + 1]);
    end
endgenerate

assign out = istart[Nr];

endmodule
