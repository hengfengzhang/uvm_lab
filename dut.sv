module dut(
  input clk,
  input rst_n,
  input [7:0] rxd,
  input rx_dv,
  output reg [7:0] txd,
  output reg tx_en
);

always @(posedge clk or negedge rst_n)
  if(!rst_n) begin
    tx_en <= 'h0;
    txd   <= 'h0;
  end else if(rx_dv) begin
    tx_en <= rx_dv;
    txd   <= rxd + 1'h1;
  end else begin
    tx_en <= 1'h0; 
  end
  
endmodule
