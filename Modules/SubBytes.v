module SubBytes(
    input [7:0] InState [0:3],
    output reg[7:0] OutState [0:3]
);
    Sbox uut(InState[0],OutState[0]);
endmodule