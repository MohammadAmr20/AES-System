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

integer i;
integer j;

wire [127:0] decrypt_final;
wire [127:0] decrypt [0:2];

localparam encr = 1'b0;
localparam decr = 1'b1;
always @(posedge clk) begin
    if(reset) begin
        i <= 0;
        j <= 0;
        msg <= 0;
        key <= 256'hx;
        SOMI <= 0;
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
                else if (i < (130 + 4*32) && size == 2'b00) begin
                    key <= {SIMO, key[255:1]};
                    i <= i + 1;
                end
                else if (i < (130 + 6*32) && size == 2'b01) begin
                    key <= {SIMO, key[255:1]};
                    i <= i + 1;
                end
                else if (i < (130 + 8*32) && size == 2'b10) begin
                    key <= {SIMO, key[255:1]};
                    i <= i + 1;
                end
            end
            else if(mode == decr)begin
                if(j<129)begin
                    SOMI = decrypt_final[j];
                    j=j+1;
                end
            end
        end
    end
end

AES #(4, 10) aes1 (msg, key[255 -: 128], decrypt[0]);
AES #(6, 12) aes2 (msg, key[255 -: 192], decrypt[1]);
AES #(8, 14) aes3 (msg, key[255 -: 256], decrypt[2]);

assign decrypt_final = (reset) ? 0 : (size == 2'b00) ? decrypt[0] : (size == 2'b01) ? decrypt[1] : decrypt[2];

endmodule
