class dut_model extends uvm_component;
  `uvm_component_utils(dut_model)

  uvm_blocking_get_port #(dut_trans) in_port;
  uvm_analysis_port #(dut_trans) out_port;


  function new(string name = "dut_model", uvm_component parent);
    super.new(name, parent);
  endfunction:new 

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    in_port = new("in_port", this);
    out_port = new("out_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    dut_trans my_trans;
    dut_trans new_trans;
    super.run_phase(phase);
    while(1) begin
      in_port.get(my_trans);
      new_trans = new("new_trans");
      new_trans = my_trans;
      new_trans.data = new_trans.data + 1'h1;
      out_port.write(new_trans);
    end
  endtask

endclass
