class dut_scb extends uvm_component;
  `uvm_component_utils(dut_scb)

  uvm_blocking_get_port #(dut_trans) exp_port;
  uvm_blocking_get_port #(dut_trans) act_port;

  dut_trans exp_trans;
  dut_trans act_trans;

  dut_trans tmp_exp_trans;
  dut_trans tmp_act_trans;

  dut_trans act_queue[$];
  dut_trans exp_queue[$];

  bit result;

  function new(string name = "dut_scb", uvm_component parent);
    super.new(name, parent);
  endfunction:new 

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      while(1) begin
        exp_port.get(exp_trans);
        exp_queue.push_back(exp_trans);
      end
      while(1) begin
        act_port.get(act_trans);
        if(null != act_trans)
          wait(exp_queue.size()>0)begin
            tmp_exp_trans = exp_queue.pop_front();
            result = act_trans.data == tmp_exp_trans.data;
            if(result) begin
              `uvm_info(get_full_name(), $sformatf("Pass #Get new trans: exp %h; act %h", tmp_exp_trans.data, act_trans.data), UVM_LOW)
            end else begin
              `uvm_info(get_full_name(), $sformatf("Fail #Get new trans: exp %h; act %h", tmp_exp_trans.data, act_trans.data), UVM_LOW)
            end
          end
      end
    join
  endtask

endclass
