module SubBytes (
    input [127:0] InState ,
    output [127:0] OutState
);
    genvar i  ;
    generate
        for (i = 0  ; i < 128 ; i = i + 8) begin : Sub_Bytes
            Sbox uut(InState[i+7 : i],OutState[i+7:i]);
        end
    endgenerate
endmodule