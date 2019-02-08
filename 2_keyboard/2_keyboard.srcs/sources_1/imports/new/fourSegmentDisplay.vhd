----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/16/2018 01:54:10 PM
-- Design Name:
-- Module Name: segmentDisplay - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- This source file's filetype has to be set to VHDL2008 (in Source File Properties)
-- to enable the `with .. select` statement in updateDisplay();
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fourSegmentDisplay is
    port ( 
        clk  : in  std_logic;
        bcd  : in  std_logic_vector(15 downto 0);
        an   : out std_logic_vector(3 downto 0);
        seg  : out std_logic_vector(6 downto 0)
        );
end fourSegmentDisplay;


architecture Behavioral of fourSegmentDisplay is
    signal      counter         : integer;
    constant    counterInterval : integer   := (10**5)*2;
    signal      currentDisplay  : integer   range 3 downto 0;
begin

-- switch segment display at 500 Hz
-- This is within the recommended frequency range of 1kHz-60Hz
    setDisplay : process(clk, counter)

    begin

        if rising_edge(clk) then
            counter     <= (counter + 1);
            if counter  = counterInterval then
                -- reset counter
                counter <= 0;
                -- increment currentDisplay (at the end of process)
                -- because currentDisplay is created as a 2-bit counter
                -- it will roll over from 3->0
                CurrentDisplay <= (CurrentDisplay + 1);
            end if;

        end if;
    end process;

    updateDisplay : process(currentDisplay, bcd)

        variable varBcd : std_logic_vector(3 downto 0);

    begin

            -- get the relevant slice of BCD
            varBcd := bcd((CurrentDisplay*4)+3 downto (CurrentDisplay*4));

            -- disable all segment displays
            -- both an and seg are active low
            an  <= "1111";
            seg <= "1111111";
            -- enable the display that needs to be enabled
            an(currentDisplay) <= '0';

            -- seg[6:0] == [g:a]
            with varBcd select
            seg <= "1000000" when "0000", -- 0
                   "1111001" when "0001", -- 1
                   "0100100" when "0010", -- 2
                   "0110000" when "0011", -- 3
                   "0011001" when "0100", -- 4
                   "0010010" when "0101", -- 5
                   "0000010" when "0110", -- 6
                   "1111000" when "0111", -- 7
                   "0000000" when "1000", -- 8
                   "0010000" when "1001", -- 9
                   "0111111" when others; -- -

    end process;

end Behavioral;
