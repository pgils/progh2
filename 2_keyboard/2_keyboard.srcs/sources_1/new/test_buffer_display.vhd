----------------------------------------------------------------------------------
-- Engineer: Pelle van Gils
-- 
-- Create Date: 02/08/2019 03:42:44 PM
-- Module Name: test_buffer_display - Behavioral
-- Project Name: 2_keyboard
-- Description: 
--  Hardware testbench for testing `digitBuffer` in conjunction with `foursegmentDisplay`
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
use IEEE.NUMERIC_STD.ALL;

entity test_buffer_display is
    port (
        sysclk      : in  std_logic;
        an          : out std_logic_vector(3 downto 0);
        seg         : out std_logic_vector(6 downto 0)
        );
end test_buffer_display;

architecture Behavioral of test_buffer_display is

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

signal      keyPressed      : std_logic := '0';
signal      keyData         : std_logic_vector(3 downto 0) := "1001"; -- 9
signal      bcdBuffer       : std_logic_vector(15 downto 0);

signal      counter         : integer   := 0;
constant    counterInterval : integer   := (10**8)*5;

begin

PUSH : process(sysclk)

variable newKeyData         : unsigned  := unsigned(keyData);

begin
    if rising_edge(sysclk) then
        keyPressed      <= '0';
        counter         <= (counter +1);
        if counter >= counterInterval then
            counter     <= 0;
            keyPressed  <= '1';
            newKeyData  := newKeyData +1;
            if newKeyData < 10 then
                keyData <= std_logic_vector(newKeyData);
            else
                keyData <= "0000";
                newKeyData  := unsigned(keyData);
            end if;
            
        end if;
    end if;
end process PUSH;

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
