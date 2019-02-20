-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Wed Feb 20 20:25:15 2019
-- Host        : vhdl.pollop.nl running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /media/sf_shared/PROGH2/LES3_VGA_HD_timing_issues_smly/VGA_HD.srcs/sources_1/ip/Clk_148/Clk_148_stub.vhdl
-- Design      : Clk_148
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clk_148 is
  Port ( 
    clk148 : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk100 : in STD_LOGIC
  );

end Clk_148;

architecture stub of Clk_148 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk148,reset,clk100";
begin
end;
