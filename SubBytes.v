`include "Sbox.v"
module SubBytes #(parameter SIZE = 128)(
    input [SIZE-1:0] InState ,
    output [SIZE-1:0] OutState
);
    genvar i  ;
    generate
        for (i = 0  ; i < SIZE ; i = i + 8) begin : Sub_Bytes
            Sbox uut(InState[i+7 : i],OutState[i+7:i]);
        end
    endgenerate
endmodule