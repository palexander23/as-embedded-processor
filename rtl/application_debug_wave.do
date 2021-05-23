onerror {resume}
quietly virtual signal -install /application_cpu_stim/p0/c0/as_alu0 { /application_cpu_stim/p0/c0/as_alu0/switches[7:0]} sw
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /application_cpu_stim/clk
add wave -noupdate -radix decimal /application_cpu_stim/n_reset
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/pc_out
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/d0/opcode
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/rd
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/rs
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/rd_data
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/rs_data
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/immediate
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/add_a_sel
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/add_b_sel
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/sw
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/acc_en
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/acc_add
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/in_en
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/clk
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/n_reset
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/z
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/w_data
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/acc_out
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/mult_out
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/add_a_in
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/add_b_in
add wave -noupdate -radix decimal /application_cpu_stim/p0/c0/as_alu0/add_out
add wave -noupdate -radix decimal -childformat {{{/application_cpu_stim/p0/c0/r0/gpr[31]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[30]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[29]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[28]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[27]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[26]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[25]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[24]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[23]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[22]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[21]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[20]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[19]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[18]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[17]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[16]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[15]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[14]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[13]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[12]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[11]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[10]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[9]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[8]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[7]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[6]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[5]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[4]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[3]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[2]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[1]} -radix decimal} {{/application_cpu_stim/p0/c0/r0/gpr[0]} -radix decimal}} -subitemconfig {{/application_cpu_stim/p0/c0/r0/gpr[31]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[30]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[29]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[28]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[27]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[26]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[25]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[24]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[23]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[22]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[21]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[20]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[19]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[18]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[17]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[16]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[15]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[14]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[13]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[12]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[11]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[10]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[9]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[8]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[7]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[6]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[5]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[4]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[3]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[2]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[1]} {-height 15 -radix decimal} {/application_cpu_stim/p0/c0/r0/gpr[0]} {-height 15 -radix decimal}} /application_cpu_stim/p0/c0/r0/gpr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {39443120 ps} 0}
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
WaveRestoreZoom {82608230 ps} {207231150 ps}
