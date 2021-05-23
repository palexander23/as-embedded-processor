onerror {resume}
quietly virtual signal -install /application_cpu_stim/p0/c0/as_alu0 { /application_cpu_stim/p0/c0/as_alu0/switches[7:0]} sw
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /application_cpu_stim/n_reset
add wave -noupdate -radix decimal /application_cpu_stim/clk
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/pc_out
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/d0/opcode
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/rd
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/rs
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/rd_data
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/rs_data
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/immediate
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/sw
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/z
add wave -noupdate /application_cpu_stim/p0/c0/pc_incr
add wave -noupdate /application_cpu_stim/p0/c0/pc_relbranch
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/w_data
add wave -noupdate /application_cpu_stim/LED
add wave -noupdate -radix decimal -childformat {{{/application_cpu_stim/p0/c0/r0/gpr[4]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[3]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[2]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[1]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[0]} -radix decimal}} -expand -subitemconfig {{/application_cpu_stim/p0/c0/r0/gpr[4]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[3]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[2]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[1]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[0]} {-height 15 -radix decimal}} /application_cpu_stim/p0/c0/r0/gpr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {37651980 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 298
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {119079850 ps} {167416850 ps}
