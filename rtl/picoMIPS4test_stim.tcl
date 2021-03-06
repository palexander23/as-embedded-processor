
# NC-Sim Command File
# TOOL:	ncsim(64)	15.20-s058
#
#
# You can restore this configuration with:
#
#      ncverilog -sv +gui +ncaccess+r picoMIPS4test_stim.sv picoMIPS4test.sv cpu.sv alu.sv counter.sv decoder.sv opcodes.sv pc.sv prog.sv regs.sv +tcl+picoMIPS4test_stim.tcl +define+TESTBENCH_CLOCK
#

set tcl_prompt1 {puts -nonewline "ncsim> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias iprof profile
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves application_cpu_stim.p0.c0.n_reset application_cpu_stim.p0.c0.clk application_cpu_stim.p0.c0.pc_out application_cpu_stim.p0.c0.instr application_cpu_stim.p0.c0.Rd_data application_cpu_stim.p0.c0.Rs_data application_cpu_stim.p0.c0.SW
probe -create -database waves application_cpu_stim.p0.c0.alu_func application_cpu_stim.p0.c0.a_sel application_cpu_stim.p0.c0.b_sel application_cpu_stim.p0.c0.imm application_cpu_stim.p0.c0.w application_cpu_stim.p0.c0.alu_result application_cpu_stim.p0.c0.pc_incr application_cpu_stim.p0.c0.pc_relbranch

simvision -input picoMIPS4test_stim.tcl.svcf
