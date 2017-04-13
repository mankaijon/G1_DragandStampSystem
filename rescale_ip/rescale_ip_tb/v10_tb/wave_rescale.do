onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider General
add wave -noupdate -radix hexadecimal /v7_tb/in_memory
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/CLOCK
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/RESETN
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/GO
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/DONE
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/C_STATE
add wave -noupdate -divider Load_J
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/X_IN
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/Y_IN
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_c_j
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_r_j
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_j_unsigned
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/r_j_unsigned
add wave -noupdate -divider Start
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/start_div1
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/start_div2
add wave -noupdate -divider Wait_Div
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/done_div
add wave -noupdate -divider Load_Ratio
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_ratio_c
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_ratio_r
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ratio_c
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ratio_r
add wave -noupdate -divider Rescale_Row_J
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_r_rescaled
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/r_j_cnt_unsigned
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/r_rescaled_fl
add wave -noupdate -divider Update_rer_prevnow
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_r_rescaled_fl_prev
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_r_rescaled_fl_now
add wave -noupdate -radix decimal /v7_tb/rescale_inst/rescale_dp/r_rescaled_fl_prev
add wave -noupdate -radix decimal /v7_tb/rescale_inst/rescale_dp/r_rescaled_fl_now
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/r_rescaled_fl_diff
add wave -noupdate -divider Update_Skip
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_skip_reg
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/skip
add wave -noupdate -divider Load_Buffer_Wait
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_row_to_wait
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/row_to_wait_o
add wave -noupdate -divider Start_Buffer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_in_stream_ready
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/in_stream_ready
add wave -noupdate -divider Buffer_in_Module
add wave -noupdate /v7_tb/buffer_inst/S_AXIS_TLAST
add wave -noupdate -radix unsigned -childformat {{{/v7_tb/buffer_inst/skip_row_count[9]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[8]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[7]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[6]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[5]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[4]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[3]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[2]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[1]} -radix unsigned} {{/v7_tb/buffer_inst/skip_row_count[0]} -radix unsigned}} -subitemconfig {{/v7_tb/buffer_inst/skip_row_count[9]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[8]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[7]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[6]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[5]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[4]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[3]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[2]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[1]} {-height 15 -radix unsigned} {/v7_tb/buffer_inst/skip_row_count[0]} {-height 15 -radix unsigned}} /v7_tb/buffer_inst/skip_row_count
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay1
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay2
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_done
add wave -noupdate -divider no_skip_count
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay_rising1
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/skip_row_count
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/no_skip_cnt_is_odd
add wave -noupdate -divider inti_buffer_pointer
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_start_delay_rising2
add wave -noupdate -radix unsigned /v7_tb/buffer_inst/buffer_pointer
add wave -noupdate -divider buffer_in_data
add wave -noupdate -radix hexadecimal /v7_tb/buffer_inst/S_AXIS_TDATA
add wave -noupdate -radix hexadecimal /v7_tb/buffer_inst/buffer
add wave -noupdate -divider Rescale_Column_J
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_c_rescaled
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_j_cnt_unsigned
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_rescaled_fl
add wave -noupdate -divider Load_Neighbor_Offeset
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_neighbor_offset
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/neighbor_offset
add wave -noupdate -divider Get_Neighbor
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_neighbor0
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_neighbor1
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_neighbor2
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_neighbor3
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/neighbor0_unpad
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/neighbor1_unpad
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/neighbor2_unpad
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/neighbor3_unpad
add wave -noupdate -divider Calculate_Pixel
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/red_in
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/green_in
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/blue_in
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/red
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/green
add wave -noupdate -radix hexadecimal /v7_tb/rescale_inst/rescale_dp/blue
add wave -noupdate -divider Store_Pixel
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_store_row
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_row
add wave -noupdate -divider Next_J_Column
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_store_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_j_cnt_unsigned
add wave -noupdate -divider Store_Row
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/ld_out_stream_ready
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/out_stream_ready
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/read_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_j_unsigned_o
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_interation
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/local_read_pointer
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/out_stream_done_o
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_row
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/out_pixel_data
add wave -noupdate -radix unsigned /v7_tb/out_memory
add wave -noupdate -divider Next_J_Row
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/r_j_cnt_unsigned
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/c_j_cnt_unsigned
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/store_pointer
add wave -noupdate -divider Done
add wave -noupdate -radix unsigned /v7_tb/rescale_inst/rescale_dp/DONE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {469793 ps} 0}
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
WaveRestoreZoom {0 ps} {840 ns}
