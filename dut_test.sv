`include "dut_env.sv"

class dut_test extends uvm_test;
  
  `uvm_component_utils(dut_test)

  dut_env my_env;
  dut_seq my_seq;

  function new(string name = "dut_test", uvm_component parent);
    super.new(name, parent);
  endfunction:new 

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);

    my_env = dut_env::type_id::create("my_env", this);

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("end_of_elaboration_phase", "Entered...", UVM_LOW)

    uvm_top.print_topology();
    uvm_root::get().set_timeout(4000);
    `uvm_info("end_of_elaboration_phase", "Exiting...", UVM_LOW)
  endfunction: end_of_elaboration_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("run_phase", "Entered...", UVM_LOW)
    //tbd
    my_seq = dut_seq::type_id::create("my_seq");
    my_seq.start(my_env.my_agent_i.my_sqr);

    `uvm_info("run_phase", "Exiting...", UVM_LOW)
    phase.drop_objection(this);
  endtask: run_phase

endclass
