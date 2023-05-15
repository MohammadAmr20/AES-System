module Slave #(parameter Nk = 4, parameter Nr = 10)(
                input clk,
                input SIMO,
                input CSS,
                input mode,
                output reg SOMI                
);
reg [127:0] msg;
reg [Nk*32 - 1:0] key;

integer i = 0;
integer j = 0;

wire [127:0] decrypt;

localparam encr = 1'b0;
localparam decr = 1'b1;
always @(posedge clk) begin
    if (!CSS) begin
        if (mode == encr) begin
            if (i < 129) begin
                msg <= {SIMO, msg[127:1]};
            end
            else if (i < (130 + Nk*32)) begin
                key <= {SIMO, key[Nk*32 - 1:1]};
            end
            i <= i + 1;
        end
        else if(mode==decr)begin
            if(j<129)begin
                SOMI = decrypt[j];
                j=j+1;
            end
        end
    end
end

AES #(Nk, Nr) aes (msg, key, decrypt);


endmodule
