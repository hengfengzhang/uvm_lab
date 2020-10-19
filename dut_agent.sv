`include "dut_driver.sv"
`include "dut_monitor.sv"
`include "dut_monitor_out.sv"
`include "dut_sqr.sv"

class dut_agent extends uvm_agent;
  
  `uvm_component_utils(dut_agent)

  dut_driver my_driver;
  dut_monitor in_monitor;
  dut_monitor_out out_monitor;
  dut_sqr my_sqr;

  function new(string name = "dut_agent", uvm_component parent);
    super.new(name, parent);
  endfunction:new 

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);

    my_driver = dut_driver::type_id::create("my_driver", this);
    in_monitor = dut_monitor::type_id::create("in_monitor", this);
    out_monitor = dut_monitor_out::type_id::create("out_monitor", this);
    my_sqr = dut_sqr::type_id::create("my_sqr", this);

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("connect_phase", "Entered...", UVM_LOW)
    super.connect_phase(phase);

    if(is_active == UVM_ACTIVE)begin
      my_driver.seq_item_port.connect(my_sqr.seq_item_export);
    end

    `uvm_info("connect_phase", "Exiting...", UVM_LOW)
  endfunction: connect_phase

endclass
