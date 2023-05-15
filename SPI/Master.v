`include "Slave.v"
module Master (
                input clk,
                input reset,
                output reg led
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
reg [Nk*32 - 1:0] key;

always @(posedge clk) begin
  if (count == 49) begin
    fake_clk <= ~fake_clk;
    count <= 0;
  end else begin
    count <= count + 1;
  end
end

integer i;
integer j;
always @(posedge fake_clk) begin
    if (reset) begin
        i <= 0;
        j <= 0;
        CS <= 1'b1;
        MOSI <= 1'b0;
        mode <= encr;
        key <= 128'h2b7e151628aed2a6abf7158809cf4f3c;
        msg <= 128'h3243f6a8885a308d313198a2e0370734;
        decryption <= 128'h0;
        led <= 1'b0;
    end
    else if (!CS) begin
        if (i < 129) begin
            MOSI = msg[i];
            i = i + 1;
        end
        else if (i < (130 + 32 * Nk)) begin
            MOSI = key[i - 129];
            i = i + 1;
        end
        else if (mode == decr && j < 129) begin
            decryption <= {MISO, decryption[127:1]};
            j = j + 1;
        end
    end
end

Slave #(Nk, Nr) slave (fake_clk, MOSI, CS, mode, MISO);
assign mode = (i >= 130 + 32 * Nk) ? decr : encr;
assign led = (decryption == msg) ? 1'b1 : 1'b0;
assign CS = (!reset) ? 1'b0 : 1'b1;

endmodule
