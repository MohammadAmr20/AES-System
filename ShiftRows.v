module ShiftRows(
    input [127:0] data_in,
    output [127:0] data_out
);
    genvar i;
    generate
        for( i = 31; i < 128 ; i = i + 32)begin
            assign data_out[i : i-7] = data_in[i : i-7];
        end
        for( i = 119; i > 23 ; i = i - 32)begin
            assign data_out[i : i-7] = data_in[i-32 : i-39];
        end
        assign data_out[23:16] = data_in[119:112];
        for( i = 111; i >= 79 ; i = i - 32)begin
            assign data_out[i : i-7] = data_in[i-64 : i-71];
        end
        assign data_out[47:40] = data_in[111:104];
        assign data_out[15:8] = data_in[79:72];
        for( i = 7; i <= 71 ; i = i + 32)begin
            assign data_out[i : i-7] = data_in[i+32 : i+25];
        end
        assign data_out[103:96] = data_in[7:0];
    endgenerate
endmodule