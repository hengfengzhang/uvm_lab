module tb_top;

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "dut_test.sv"

reg clk;
reg rst_n;

initial begin
  clk <= 'h0;
  forever #5 clk = ~clk;
end

initial begin
  rst_n = 'h0;
  #13;
  rst_n = 'h1;
end

initial begin
  $fsdbDumpvars(0,tb_top,"+mda");
  #50_000;
  $finish;
end

dut_if dut_if(
  .clk(clk),
  .rst_n(rst_n)
);

dut u_dut(
  .clk(dut_if.clk),
  .rst_n(dut_if.rst_n),
  .rxd(dut_if.rxd),
  .rx_dv(dut_if.rx_dv),
  .txd(dut_if.txd),
  .tx_en(dut_if.tx_en)
);

initial begin
  uvm_config_db#(virtual dut_if)::set(null, "uvm_test_top.my_env.*.my_driver", "dut_if", dut_if);
  uvm_config_db#(virtual dut_if)::set(null, "uvm_test_top.my_env.*.*_monitor", "dut_if", dut_if);
end

initial begin
  run_test("dut_test");
end

endmodule
