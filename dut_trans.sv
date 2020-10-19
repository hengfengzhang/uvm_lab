class dut_trans extends uvm_sequence_item;
  rand bit[7:0] data;
  rand bit      en;

  //constraint data_range{
  //}

  `uvm_object_utils(dut_trans)

  function new(string name = "dut_trans");
    super.new(name);
  endfunction

  virtual task info();
    `uvm_info(this.get_full_name(),  $sformatf("The trans is : %h %h", en, data), UVM_LOW)
  endtask

endclass
