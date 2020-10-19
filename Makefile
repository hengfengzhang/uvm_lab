sim:
	vcs -full64 -ntb_opts uvm dut.sv dut_if.sv tb_top.v -sverilog -v2k -kdb -debug_access+all -R -l sim.log 

verdi:
	verdi -dbdir simv.daidir -ssf novas.fsdb &

clean:
	rm novas* *.fsdb csrc simv sim.log simv.daidir verdiLog vericomLog work.lib++ ucli.key vc_hdrs.h -rf
