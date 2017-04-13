onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib video_in_ip_0_opt

do {wave.do}

view wave
view structure
view signals

do {video_in_ip_0.udo}

run -all

quit -force
