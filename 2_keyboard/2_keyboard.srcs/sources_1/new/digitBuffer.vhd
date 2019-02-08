----------------------------------------------------------------------------------
-- Engineer: Pelle van Gils
-- 
-- Create Date: 02/08/2019 03:48:44 PM
-- Module Name: digitBuffer - Behavioral
-- Project Name: 2_keyboard
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digitBuffer is
    port (
        keyPressed      : in  std_logic;
        keyData         : in  std_logic_vector(3 downto 0);
        bcdBuffer_out   : out std_logic_vector(15 downto 0)
        );
end digitBuffer;

architecture Behavioral of digitBuffer is

signal bcdBuffer        : std_logic_vector(15 downto 0) := (others=>'0');

begin

-- push new BCD data (1 digit) onto the buffer
-- from the right/LSB side
insertToBuffer: process(keyPressed)

begin
    if rising_edge(keyPressed) then
        bcdBuffer       <= bcdBuffer(11 downto 0) & keyData;
        bcdBuffer_out   <= bcdBuffer;
    end if;
    
end process insertToBuffer;

end Behavioral;
