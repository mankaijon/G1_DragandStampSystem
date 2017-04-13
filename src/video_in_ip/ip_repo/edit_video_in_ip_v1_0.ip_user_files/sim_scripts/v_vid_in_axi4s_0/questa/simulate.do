onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib v_vid_in_axi4s_0_opt

do {wave.do}

view wave
view structure
view signals

do {v_vid_in_axi4s_0.udo}

run -all

quit -force
