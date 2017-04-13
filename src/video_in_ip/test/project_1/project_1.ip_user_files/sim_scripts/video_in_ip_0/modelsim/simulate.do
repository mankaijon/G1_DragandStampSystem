onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L fifo_generator_v13_0_3 -L v_vid_in_axi4s_v4_0_3 -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.video_in_ip_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {video_in_ip_0.udo}

run -all

quit -force
