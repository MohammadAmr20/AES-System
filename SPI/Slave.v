module Slave #(parameter Nk = 4, parameter Nr = 10)(
                input clk,
					 input reset,
                input SIMO,
                input CSS,
                input mode,
                output reg SOMI                
);
reg [127:0] msg;
reg [Nk*32 - 1:0] key;

integer i = 0;
integer j = 0;

wire [127:0] decrypt ;

localparam encr = 1'b0;
localparam decr = 1'b1;
always @(posedge clk) begin
 if(reset)begin
 msg <= 0 ;
 key <= 0 ;
 SOMI <= 0 ;
 end
 else begin
    if (!CSS) begin
        if (mode == encr) begin
            if (i < 129) begin
                msg <= {SIMO, msg[127:1]};
                i <= i + 1;
            end
	    else if(i==129)begin
	    i <= i + 1 ;
	    end
            else if (i < (130 + Nk*32)) begin
                key <= {SIMO, key[Nk*32 - 1:1]};
                i <= i + 1;
            end
        end
        else if(mode==decr)begin
            if(j<129)begin
                SOMI = decrypt[j];
                j=j+1;
            end
        end
    end
 end
end

AES #(Nk, Nr) aes (msg, key,mode, decrypt);


endmodule
