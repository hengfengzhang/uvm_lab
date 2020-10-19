class dut_sqr extends uvm_sequencer #(dut_trans);
  `uvm_component_utils(dut_sqr)

  function new(string name = "dut_sqr", uvm_component parent);
    super.new(name, parent);
  endfunction:new 

endclass
