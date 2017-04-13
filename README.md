# G1_DragandStampSystem
ECE532 Group1 project<br />
<br />
Overview<br />

The goal of the project was to create a video tracking system that can track two unique colors using a PMOD camera. The video frames are processed to detect the unique colors and track the center of each color to mark the top left and bottom right corners of the stamp that will be drawn. The design would then take a stamp from memory and scale it to fit between the two marked corners, and then write it to the display buffer to be displayed on the screen. The user would be able to select between stamps using a user interface displayed on the side.<br />
<br />
Design tree<br />
  - /doc: presentation slide and final group report
  - /src
    - /src/Draw_stamp: main project
      - /project_tracking.xpr: the main Vivado project
      -	/project_tracking.sdk
      -	/test: the SDK application, including the C source code
      -	resource_utilization.txt: the resource utilization report
    - /src/Video_in_IP: Video in IP
      -	/source: the Verilog file to configure and capture the pixel date from PMOD camera.
      -	/ ip_repo: 
      -	/ video_in_ip_1.0: the IP directory
      -	/ edit_video_in_ip_v1_0.xpr: the Vivado project for Video in IP
    - /src/Tracking_IP: 
      -	/source: the Verilog file of hardware implementation of tracking algorithm
      -	fsm.v : control logic
      -	datapath.v: datapath circuit of the tracking logic
      -	/ip_repo:
      -	/Tracking_IP_1.0: IP directory
      -	/ edit_video_in_ip_v1_0.xpr: the Vivado project for Video in IP
      -	BMP_testbench: the BMP testbench for tracking logic
    - /Rescale_IP
      -	rescale_ip foler: 
      -	helloworld.c is C program used to control the system in SDK tool
      -	pin_assignment_video_in.xdc is the pin assignment sheet for the rescaling system
      -	smile_nohead.bmp is an example picture that can be used to rescale
      -	rescale_ip_src folder:
      -	V9 folder contains the Verilog codes for rescale_v2_0 IP
      -	V10 folder contains the Verilog codes for rescale_v3_0 IP
      -	resource_utilization (V9).txt is the utilization report for system with rescale_v2_0 IP
      -	resource_utilization(V10).txt is the utilization report for system with rescale_v3_0 IP
      -	rescale_ip_tb folder:
      -	v9_tb folder contains the testbench source and format .do files for waveform (ModelSim)
      -	v10_tb folder contains the testbench source and format .do files for waveform (ModelSim)
<br />
How to use<br />

If you wish to properly build the main system:
  - Navitage to /src/Draw_stamp and open project_tracking.xpr with Vivado
  - Generate bitstream with Vivado and export to SDK
  - Open up test application and the associated support package (test_bsd).
  - Run the application
  
Author<br />

Qijun Wen<br />
Weigen Yuan<br />
Brandon Norberto<br />

