----------------------------------------------------------------------------------
-- Engineer: Pelle van Gils
-- 
-- Create Date: 01/30/2019 11:56:51 PM
-- Module Name: sound_test - Behavioral
-- Project Name: 1-Sound
-- Description: 
--  Simple testbench for sound.vhd
-- Dependencies: 
--  sound.vhd
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sound_test is
--  Port ( );
end sound_test;

architecture Behavioral of sound_test is


component sound is
  port ( 
    clk         : in  std_logic;
    PIN_MONO    : out std_logic
  );
end component sound;

signal clk          : std_logic := '0';
signal sigOutput    : std_logic;

begin

clk <= not clk after 10ns;

SND : sound port map (
    clk         => clk,
    PIN_MONO    => sigOutput);


end Behavioral;
