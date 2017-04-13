vlib work
vlib riviera

vlib riviera/fifo_generator_v13_0_3
vlib riviera/v_vid_in_axi4s_v4_0_3
vlib riviera/xil_defaultlib

vmap fifo_generator_v13_0_3 riviera/fifo_generator_v13_0_3
vmap v_vid_in_axi4s_v4_0_3 riviera/v_vid_in_axi4s_v4_0_3
vmap xil_defaultlib riviera/xil_defaultlib

vcom -work fifo_generator_v13_0_3 -93 \
"../../../ipstatic/fifo_generator_v13_0_3/simulation/fifo_generator_vhdl_beh.vhd" \
"../../../ipstatic/fifo_generator_v13_0_3/hdl/fifo_generator_v13_0_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_3 -v2k5 \
"../../../ipstatic/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0_coupler.v" \
"../../../ipstatic/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0_formatter.v" \
"../../../ipstatic/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0.v" \

vlog -work xil_defaultlib -v2k5 \
"../../../../edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/sim/v_vid_in_axi4s_0.v" \

vlog -work xil_defaultlib "glbl.v"

