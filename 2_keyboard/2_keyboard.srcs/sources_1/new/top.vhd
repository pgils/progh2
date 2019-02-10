----------------------------------------------------------------------------------
-- Engineer: Pelle van Gils
-- 
-- Create Date: 02/08/2019 11:39:01 PM
-- Module Name: top - Behavioral
-- Project Name: 2_keyboard
-- Description: 
-- 
-- Dependencies: 
--  digitBuffer.vhd
--  fourSegmentDisplay.vhd
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port (
        sysclk          : in  std_logic;
        PS2Clk          : in  std_logic;
        PS2Data         : in  std_logic;
        an              : out std_logic_vector(3 downto 0);
        seg             : out std_logic_vector(6 downto 0)
    );
end top;

architecture Behavioral of top is

component digitBuffer is
    port (
        keyPressed      : in  std_logic;
        keyData         : in  std_logic_vector(3 downto 0);
        bcdBuffer_out   : out std_logic_vector(15 downto 0)
        );
end component;

component fourSegmentDisplay is
    port ( 
        clk             : in  std_logic;
        bcd             : in  std_logic_vector(15 downto 0);
        an              : out std_logic_vector(3 downto 0);
        seg             : out std_logic_vector(6 downto 0)
        );
end component;


component keyboardHandler is
    port (
        sysclk          : in  std_logic;
        PS2Clk          : in  std_logic;
        PS2Data         : in  std_logic;
        keyPressed      : out std_logic;
        keyData         : out std_logic_vector(3 downto 0)
        );
end component;

signal  keyPressed      : std_logic := '0';
signal  keyData         : std_logic_vector(3 downto 0);
signal  bcdBuffer       : std_logic_vector(15 downto 0);

begin

KBD : keyboardHandler
    port map (
        sysclk          => sysclk,
        PS2Clk          => PS2Clk,
        PS2Data         => PS2Data,
        keyPressed      => keyPressed,
        keyData         => keyData
    );

BUF : digitBuffer
    port map (
        keyPressed      => keyPressed,
        keyData         => keyData,
        bcdBuffer_out   => bcdBuffer
    );
    
FSD : fourSegmentDisplay
    port map (
        clk             => sysclk,
        bcd             => bcdBuffer,
        an              => an,
        seg             => seg
    );

end Behavioral;
