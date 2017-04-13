onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/NO_SKIP_NUMBER_OF_INPUT_WORDS
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/NUMBER_OF_INPUT_WORDS
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/S_AXIS_TVALID
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/resetn
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/clock
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/S_AXIS_TLAST
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/skip
add wave -noupdate -divider ready
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/S_AXIS_TREADY
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/BUFFER_START_DELAY_O
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/in_stream_ready
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/axis_tready
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/writes_done
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/mst_exec_state
add wave -noupdate -divider ready/start
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/row_to_wait
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/skip_row_count
add wave -noupdate /v7_tb/rescale_v2_0_S_IN_AXIS_inst/in_stream_ready
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_done
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_done_reset_delay
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay1
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay_o
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay2
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start
add wave -noupdate -divider start
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/S_AXIS_TDATA
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_pointer
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/NO_SKIP_NUMBER_OF_INPUT_WORDS
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/NUMBER_OF_INPUT_WORDS
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/S_AXIS_TVALID
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/resetn
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/clock
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/S_AXIS_TLAST
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/skip
add wave -noupdate -divider ready
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/S_AXIS_TREADY
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/BUFFER_START_DELAY_O
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/in_stream_ready
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/axis_tready
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/writes_done
add wave -noupdate -radix unsigned /v7_tb/rescale_v2_0_S_IN_AXIS_inst/mst_exec_state
add wave -noupdate -divider ready
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/row_to_wait
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/skip_row_count
add wave -noupdate /v7_tb/rescale_v2_0_S_IN_AXIS_inst/in_stream_ready
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_done
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay1
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay_o
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay2
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/S_AXIS_TDATA
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_pointer
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86129 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
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
WaveRestoreZoom {0 ps} {295960 ps}
