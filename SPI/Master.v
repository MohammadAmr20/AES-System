module Master (
                input clk,
                input reset,
				input enable,
                input [1:0] size,
                output led,
                output reg leds
);

localparam Nk = 4;
localparam Nr = 10;
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
        leds <= 1'b0;
        MOSI <= 1'b0;
        mode <= encr;
        key1 <= 128'h2b7e151628aed2a6abf7158809cf4f3c;
        key2 <= 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
        key3 <= 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        msg <= 128'h3243f6a8885a308d313198a2e0370734;
        decryption <= 128'h0;
		  similar <= 1'b1;
    end
	 else if (!reset && CS) begin
		  CS <= 1'b0;
	 end
    else if (!CS) begin
        if (i < 129) begin
            MOSI <= msg[i];
            i <= i + 1;
        end
        else if (i < (130 + 32 * Nk) ) begin
            MOSI <= key[i - 129];
            i <= i + 1;
        end
        else if (i >= 130 + 32 * Nk && mode == encr) begin
					      mode <= decr;
            end
        else if (mode == decr && j < 129) begin
            decryption <= {MISO, decryption[127:1]};
            j <= j + 1;
        end
		else if (decryption == msg) begin
				leds <= 1'b1;
		end
    end
  end
end

Slave slave (fake_clk, reset, MOSI, CS, mode, size, MISO);

assign led = (j == 129) ? 1'b1 : 1'b0;

endmodule
