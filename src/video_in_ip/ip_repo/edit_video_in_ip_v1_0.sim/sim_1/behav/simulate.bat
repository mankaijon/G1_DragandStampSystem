@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim video_in_ip_v1_0_behav -key {Behavioral:sim_1:Functional:video_in_ip_v1_0} -tclbatch video_in_ip_v1_0.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
