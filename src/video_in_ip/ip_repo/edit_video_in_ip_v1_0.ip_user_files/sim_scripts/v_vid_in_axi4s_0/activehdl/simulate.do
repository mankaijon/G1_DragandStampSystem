onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+v_vid_in_axi4s_0 -L unisims_ver -L unimacro_ver -L secureip -L fifo_generator_v13_0_3 -L v_vid_in_axi4s_v4_0_3 -L xil_defaultlib -O5 xil_defaultlib.v_vid_in_axi4s_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {v_vid_in_axi4s_0.udo}

run -all

endsim

quit -force
