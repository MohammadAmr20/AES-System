module MixColumns (
    input [127:0] InState,
    output[127:0] OutState
);

    
function [7:0] Mult2;
    input [7:0] x;
    begin 
            if(x[7] == 1) Mult2 = ((x << 1) ^ 8'h1b);
            else Mult2 = x << 1; 
    end     
endfunction

function [7:0] Mult3;
    input [7:0] x;
    begin 
            
            Mult3 = Mult2(x) ^ x;
    end 
endfunction

genvar i;
generate
    for(i = 0; i < 4; i = i + 1) begin
        assign OutState[(127 - 32 * i)-:8] = Mult2(InState[(127 - 32 * i)-:8]) ^ Mult3(InState[(119 - 32 * i)-:8])
        ^ InState[(111 - 32 * i)-:8] ^ InState[(103 - 32 * i)-:8];
        assign OutState[(119 - 32 * i)-:8] = InState[(127 - 32 * i)-:8] ^ Mult2(InState[(119 - 32 * i)-:8])
        ^ Mult3(InState[(111 - 32 * i)-:8]) ^ InState[(103 - 32 * i)-:8];
        assign OutState[(111 - 32 * i)-:8] = InState[(127 - 32 * i)-:8] ^ InState[(119 - 32 * i)-:8]
        ^ Mult2(InState[(111 - 32 * i)-:8]) ^ Mult3(InState[(103 - 32 * i)-:8]);
        assign OutState[(103 - 32 * i)-:8] = Mult3(InState[(127 - 32 * i)-:8]) ^ InState[(119 - 32 * i)-:8]
        ^ InState[(111 - 32 * i)-:8] ^ Mult2(InState[(103 - 32 * i)-:8]);
    end
endgenerate

endmodule