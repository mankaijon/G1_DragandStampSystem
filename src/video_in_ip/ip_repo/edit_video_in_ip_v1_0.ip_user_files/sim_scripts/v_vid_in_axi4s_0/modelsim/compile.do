vlib work
vlib msim

vlib msim/fifo_generator_v13_0_3
vlib msim/v_vid_in_axi4s_v4_0_3
vlib msim/xil_defaultlib

vmap fifo_generator_v13_0_3 msim/fifo_generator_v13_0_3
vmap v_vid_in_axi4s_v4_0_3 msim/v_vid_in_axi4s_v4_0_3
vmap xil_defaultlib msim/xil_defaultlib

vcom -work fifo_generator_v13_0_3 -64 -93 \
"../../../ipstatic/fifo_generator_v13_0_3/simulation/fifo_generator_vhdl_beh.vhd" \
"../../../ipstatic/fifo_generator_v13_0_3/hdl/fifo_generator_v13_0_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_3 -64 -incr \
"../../../ipstatic/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0_coupler.v" \
"../../../ipstatic/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0_formatter.v" \
"../../../ipstatic/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../../edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/sim/v_vid_in_axi4s_0.v" \

vlog -work xil_defaultlib "glbl.v"

