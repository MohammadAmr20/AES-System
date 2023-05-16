module Master (
                input clk,
                input reset,
				        input enable,
                input [1:0] size,
                output led_fin,
                output reg led_decryption
);

localparam encr = 1'b0;
localparam decr = 1'b1;


wire MISO;


reg MOSI, CS;
reg fake_clk = 1'b0;
reg [5:0] count = 6'b0;
reg mode;
reg [127:0] decryption;
reg [127:0] msg;
reg [127:0] key1;
reg [191:0] key2;
reg [255:0] key3;
reg [255:0] key;
reg similar;


always @(posedge clk) begin
  if(enable)begin
  	if (count == 49) begin
    	fake_clk <= ~fake_clk;
    	count <= 0;
  	end else begin
    	count <= count + 1;
  	end
  end
end

integer i;
integer j;
always @(posedge fake_clk) begin
 if(enable)begin
    if (reset) begin
        i <= 0;
        j <= 0;
        CS <= 1'b1;
        led_decryption <= 1'b0;
        MOSI <= 1'b0;
        mode <= encr;
        key1 <= 128'h2b7e151628aed2a6abf7158809cf4f3c;
        key2 <= 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
        key3 <= 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        key <= 256'h0;
        msg <= 128'h3243f6a8885a308d313198a2e0370734;
        decryption <= 128'h0;
		    similar <= 1'b1;
    end
	  else if (CS) begin
		    CS <= 1'b0;
        if (size == 2'b00) begin
            key[255 -: 128] <= key1;
        end
        else if (size == 2'b01) begin
            key[255 -: 192] <= key2;
        end
        else if (size == 2'b10) begin
            key <= key3;
        end
	  end
    else if (!CS) begin
        if (i < 129) begin
            MOSI <= msg[i];
            i <= i + 1;
        end
        else if (size == 2'b00) begin
            if (i < (130 + 32 * 4)) begin
                MOSI <= key[128 + i - 129];
                i <= i + 1;
            end
            else if (i >= 130 + 32 * 4 && mode == encr) begin
				    	      mode <= decr;
                end
            else if (mode == decr && j < 129) begin
                decryption <= {MISO, decryption[127:1]};
                j <= j + 1;
            end
        end
        else if (size == 2'b01) begin
            if (i < (130 + 32 * 6)) begin
                MOSI <= key[64 + i - 129];
                i <= i + 1;
            end
            else if (i >= 130 + 32 * 6 && mode == encr) begin
				    	      mode <= decr;
                end
            else if (mode == decr && j < 129) begin
                decryption <= {MISO, decryption[127:1]};
                j <= j + 1;
            end
        end
        else if (size == 2'b10) begin
            if (i < (130 + 32 * 8)) begin
                MOSI <= key[i - 129];
                i <= i + 1;
            end
            else if (i >= 130 + 32 * 8 && mode == encr) begin
				    	      mode <= decr;
                end
            else if (mode == decr && j < 129) begin
                decryption <= {MISO, decryption[127:1]};
                j <= j + 1;
            end
        end
		    else if (decryption ^ msg == 0) begin
				    led_decryption <= 1'b1;
		    end
    end
  end
end

Slave slave (fake_clk, reset, MOSI, CS, mode, size, MISO);

assign led_fin = (j >= 129) ? 1'b1 : 1'b0;

endmodule
