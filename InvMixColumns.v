module InvMixColumns (
    input [127:0] data_in,
    output[127:0] data_out
);

    
function[7:0] Two_Powers(input [7:0]x,input integer n);
integer i;
begin
    for(i = 0; i < n; i = i + 1)begin
        if(x[7] == 1) x = ((x << 1) ^ 8'h1b);
        else x = x << 1; 
    end
    Two_Powers = x;
end

endfunction

// mult0e = 14 --> 8 + 4 + 2
// mult0d = 13 --> 8 + 4 + 1
// mult9 = 9 --> 8 + 1
// mult0b = 11 --> 8 + 2 + 1

function [7:0] Mult0e;
    input [7:0] x;
    begin
        Mult0e = Two_Powers(x, 3) ^ Two_Powers(x, 2) ^ Two_Powers(x, 1); 
    end
endfunction

function [7:0] Mult0b;
    input [7:0] x;
    begin
        Mult0b = Two_Powers(x, 3) ^ Two_Powers(x, 1) ^ x; 
    end
endfunction

function [7:0] Mult9;
    input [7:0] x;
    begin
        Mult9 = Two_Powers(x, 3) ^ x;
    end
endfunction

function [7:0] Mult0d;
    input [7:0] x;
    begin
        Mult0d = Two_Powers(x, 3) ^ Two_Powers(x, 2) ^ x;
    end
endfunction


genvar i;
generate
    for(i = 0; i < 4; i = i + 1) begin
        assign data_out[(127 - 32 * i)-:8] = Mult0e(data_in[(127 - 32 * i)-:8]) ^ Mult0b(data_in[(119 - 32 * i)-:8])
        ^ Mult0d(data_in[(111 - 32 * i)-:8]) ^ Mult9(data_in[(103 - 32 * i)-:8]);
        assign data_out[(119 - 32 * i)-:8] = Mult9(data_in[(127 - 32 * i)-:8]) ^ Mult0e(data_in[(119 - 32 * i)-:8])
        ^ Mult0b(data_in[(111 - 32 * i)-:8]) ^ Mult0d(data_in[(103 - 32 * i)-:8]);
        assign data_out[(111 - 32 * i)-:8] = Mult0d(data_in[(127 - 32 * i)-:8]) ^ Mult9(data_in[(119 - 32 * i)-:8])
        ^ Mult0e(data_in[(111 - 32 * i)-:8]) ^ Mult0b(data_in[(103 - 32 * i)-:8]);
        assign data_out[(103 - 32 * i)-:8] = Mult0b(data_in[(127 - 32 * i)-:8]) ^ Mult0d(data_in[(119 - 32 * i)-:8])
        ^ Mult9(data_in[(111 - 32 * i)-:8]) ^ Mult0e(data_in[(103 - 32 * i)-:8]);
    end
endgenerate

endmodule