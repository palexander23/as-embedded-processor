onerror {resume}
quietly virtual signal -install /as_alu_stim/as_alu0 { /as_alu_stim/as_alu0/switches[7:0]} sw_7_0
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/rd_data
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/rs_data
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/immediate
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/sw_7_0
add wave -noupdate -radix binary {/as_alu_stim/as_alu0/switches[8]}
add wave -noupdate -radix binary /as_alu_stim/as_alu0/acc_en
add wave -noupdate -radix binary /as_alu_stim/as_alu0/acc_add
add wave -noupdate -radix binary /as_alu_stim/as_alu0/in_en
add wave -noupdate -radix binary /as_alu_stim/as_alu0/clk
add wave -noupdate -radix binary /as_alu_stim/as_alu0/n_reset
add wave -noupdate -radix binary /as_alu_stim/as_alu0/z
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/w_data
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/acc_out
add wave -noupdate -radix binary /as_alu_stim/as_alu0/add_a_sel
add wave -noupdate -radix binary /as_alu_stim/as_alu0/add_b_sel
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/mult_out
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/add_a_in
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/add_b_in
add wave -noupdate -radix decimal /as_alu_stim/as_alu0/add_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2666160 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 203
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ps} {16800 ns}
