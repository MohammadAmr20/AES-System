module Slave (
                input clk,
		        input reset,
                input SIMO,
                input CSS,
                input mode,
                input [1:0] size,
                output reg SOMI                
);
reg [127:0] msg;
reg [255:0] key;

integer i = 0;
integer j = 0;

wire [127:0] decrypt;
integer Nk = (size == 2'b00) ? 4 : (size == 2'b01) ? 6 : 8;
integer Nr = (size == 2'b00) ? 10 : (size == 2'b01) ? 12 : 14;
wire [127:0] decrypt [2:0];

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

AES #(Nk, Nr) aes (msg, key, decrypt);


endmodule
