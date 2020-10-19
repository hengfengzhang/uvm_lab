`include "dut_agent.sv"
`include "dut_model.sv"
`include "dut_scb.sv"
`include "dut_seq.sv"

class dut_env extends uvm_env;
  
  `uvm_component_utils(dut_env)

  dut_agent my_agent_i;
  dut_agent my_agent_o;

  dut_model my_model;

  dut_scb my_scb;

  dut_seq my_seq;

  uvm_tlm_analysis_fifo #(dut_trans) drv2sco_port_fifo;
  uvm_tlm_analysis_fifo #(dut_trans) mon2sco_port_fifo;
  uvm_tlm_analysis_fifo #(dut_trans) mod2sco_port_fifo;

  function new(string name = "dut_env", uvm_component parent);
    super.new(name, parent);
  endfunction:new 

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);

    my_agent_i = dut_agent::type_id::create("my_agent_i", this);

    my_model = dut_model::type_id::create("my_model", this);

    my_scb = dut_scb::type_id::create("my_scb", this);

    drv2sco_port_fifo = new("drv2sco_port_fifo", this);
    mon2sco_port_fifo = new("mon2sco_port_fifo", this);
    mod2sco_port_fifo = new("mod2sco_port_fifo", this);

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("connect_phase", "Entered...", UVM_LOW)
    super.connect_phase(phase);

    my_agent_i.in_monitor.out_port.connect(drv2sco_port_fifo.analysis_export);
    my_model.in_port.connect(drv2sco_port_fifo.blocking_get_export);

    my_model.out_port.connect(mod2sco_port_fifo.analysis_export);
    my_scb.exp_port.connect(mod2sco_port_fifo.blocking_get_export);

    my_agent_i.out_monitor.out_port.connect(mon2sco_port_fifo.analysis_export);
    my_scb.act_port.connect(mon2sco_port_fifo.blocking_get_export);

    `uvm_info("connect_phase", "Exiting...", UVM_LOW)
  endfunction: connect_phase

endclass
