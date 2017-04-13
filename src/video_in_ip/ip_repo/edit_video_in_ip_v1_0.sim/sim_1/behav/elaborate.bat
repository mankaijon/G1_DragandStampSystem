@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto c483d99e1608417d94bd0e54eb9bae8d -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L fifo_generator_v13_0_3 -L v_vid_in_axi4s_v4_0_3 -L unisims_ver -L unimacro_ver -L secureip --snapshot video_in_ip_v1_0_behav xil_defaultlib.video_in_ip_v1_0 xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
