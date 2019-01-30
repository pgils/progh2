-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Wed Jan 30 22:30:50 2019
-- Host        : vhdl.pollop.nl running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /media/sf_shared/PROGH2/1-sound/1-sound.srcs/sources_1/ip/blkMemBertErnie/blkMemBertErnie_stub.vhdl
-- Design      : blkMemBertErnie
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity blkMemBertErnie is
  Port ( 
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end blkMemBertErnie;

architecture stub of blkMemBertErnie is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,addra[12:0],douta[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_1,Vivado 2018.2";
begin
end;
