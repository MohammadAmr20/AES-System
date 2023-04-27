`include "ShiftRows.v"
`include "Sbox.v"
module Cipher (
                input [127:0] in,
                output [127:0] s_box,
		            output [127:0] s_row,
                output [127:0] out
);

Sbox sbox(in, s_box);

ShiftRows shift_rows(s_box, s_row);
endmodule
