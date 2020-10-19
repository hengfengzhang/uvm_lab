class dut_monitor_out extends uvm_monitor;
   `uvm_component_utils(dut_monitor_out)

   virtual dut_if dut_if;
   dut_trans my_trans;
   uvm_analysis_port #(dut_trans) out_port;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("driver build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);

    out_port = new("out_port", this);

    `uvm_info("driver build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("monitor_out connect_phase", "Entered...", UVM_LOW)
    super.connect_phase(phase);

    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_if)) begin
      `uvm_error("monitor_out connect_phase", "Cannot get dut_if from tb_top");
    end

    `uvm_info("monitor_out connect_phase", "Exiting...", UVM_LOW)
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
      //phase.raise_objection(this);
      `uvm_info("monitor_out run_phase", "Entered...", UVM_LOW)
  
      wait(dut_if.rst_n);
      for(int i=0;i<100;i++)begin
        @(posedge dut_if.clk);
        if(dut_if.tx_en) begin
          my_trans = new("my_trans");
          my_trans.data = dut_if.txd;
          my_trans.en   = dut_if.tx_en;
          out_port.write(my_trans);
        end
      end
  
      `uvm_info("monitor_out run_phase", "Exiting...", UVM_LOW)
      //phase.drop_objection(this);
  endtask

endclass : dut_monitor_out



