-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_wrapper is
  Port ( 
    BTNC : in STD_LOGIC;
    LEDR : out STD_LOGIC_VECTOR ( 0 to 0 );
    OV7670_D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    OV7670_HREF : in STD_LOGIC;
    OV7670_PCLK : in STD_LOGIC;
    OV7670_SIOC : out STD_LOGIC;
    OV7670_SIOD : inout STD_LOGIC;
    OV7670_VSYNC : in STD_LOGIC;
    OV7670_XCLK : out STD_LOGIC;
    clock_rtl : in STD_LOGIC;
    m00_axis_tready : in STD_LOGIC;
    pwdn : out STD_LOGIC;
    resetI2C : out STD_LOGIC;
    reset_rtl : in STD_LOGIC
  );

end design_1_wrapper;

architecture stub of design_1_wrapper is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
begin
end;
