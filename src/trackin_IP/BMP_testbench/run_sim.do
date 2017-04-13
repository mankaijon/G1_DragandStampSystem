file mkdir out

vlib work

vlog src/track_top.v
vlog src/fsm.v
vlog src/datapath.v
vlog src/abs.v
vlog src/tb.sv

vsim -gui work.tb

run -all

exit
