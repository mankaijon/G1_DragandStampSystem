onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider store_row
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_cp/n_state
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_j_unsigned_o
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_interation
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/out_stream_ready
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/out_stream_done_o
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/read_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/local_read_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_row
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/out_pixel_data
add wave -noupdate -divider m_axis
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/M_AXIS_TREADY
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/tx_en
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/read_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/local_read_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_row
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/M_AXIS_TDATA
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/M_AXIS_TVALID
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/M_AXIS_TLAST
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_M_OUT_AXIS_inst/m_axis_s2mm_tuser
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {198852 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {177159 ps} {209217 ps}
