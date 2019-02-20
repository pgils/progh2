-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Wed Feb 20 20:26:56 2019
-- Host        : vhdl.pollop.nl running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /media/sf_shared/PROGH2/LES3_VGA_HD_timing_issues_smly/VGA_HD.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_stub.vhdl
-- Design      : blk_mem_gen_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity blk_mem_gen_0 is
  Port ( 
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 13 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rsta_busy : out STD_LOGIC
  );

end blk_mem_gen_0;

architecture stub of blk_mem_gen_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,rsta,addra[13:0],douta[11:0],rsta_busy";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_1,Vivado 2018.2";
begin
end;
