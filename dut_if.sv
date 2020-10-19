interface dut_if(input clk,input rst_n);

  logic [7:0] rxd;
  logic rx_dv;
  logic [7:0] txd;
  logic tx_en;

endinterface
