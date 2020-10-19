class dut_seq extends uvm_sequence #(dut_trans);
  `uvm_object_utils(dut_seq)
  dut_trans my_trans;

  function new(string name = "dut_seq");
    super.new(name);
  endfunction:new 

  virtual task body();
    repeat(100)begin
      `uvm_do(my_trans)
    end
  endtask

endclass
