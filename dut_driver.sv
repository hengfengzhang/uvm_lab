`include "dut_trans.sv"
class dut_driver extends uvm_driver #(dut_trans);
   `uvm_component_utils(dut_driver)


   virtual dut_if dut_if;
   dut_trans my_trans;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("driver build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);

    `uvm_info("driver build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("driver connect_phase", "Entered...", UVM_LOW)
    super.connect_phase(phase);

    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_if)) begin
      `uvm_error("driver connect_phase", "Cannot get dut_if from tb_top");
    end

    `uvm_info("driver connect_phase", "Exiting...", UVM_LOW)
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
      //phase.raise_objection(this);
      `uvm_info("driver run_phase", "Entered...", UVM_LOW)
  
      dut_if.rxd   = 8'h0;
      dut_if.rx_dv = 1'h0;
      wait(dut_if.rst_n);
      for(int i=0;i<100;i++)begin
        @(posedge dut_if.clk);
        my_trans = new("my_trans");
        seq_item_port.get_next_item(my_trans);
        dut_if.rxd   <= #1 my_trans.data;
        dut_if.rx_dv <= #1 my_trans.en;
        seq_item_port.item_done();
      end
  
      `uvm_info("driver run_phase", "Exiting...", UVM_LOW)
      //phase.drop_objection(this);
  endtask

endclass : dut_driver



