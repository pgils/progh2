----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2019 12:10:46 AM
-- Design Name: 
-- Module Name: keyboardHandler - Behavioral
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity keyboardHandler is
    port (
        sysclk      : in  std_logic;
        PS2Clk      : in  std_logic;
        PS2Data     : in  std_logic;
        keyPressed  : out std_logic;
        keyData     : out std_logic_vector(3 downto 0)
        );
end keyboardHandler;

architecture Behavioral of keyboardHandler is

-- buffers: 3 bits (flip-flops) for stabilizing the signal
-- and extra bit for clk for comparing to HIGH-1 for edge detection.
signal  clkBuffer   : std_logic_vector(3 downto 0)  := "1111";
signal  dataBuffer  : std_logic_vector(2 downto 0)  := "111";

-- 11-bit word as sent by the PS/2 device
signal  dataWord    : std_logic_vector(10 downto 0)  := (others=>'0');
signal  wordIndex   : integer := 0;


function scancodeToBCD(scancode: in std_logic_vector(7 downto 0))
    return std_logic_vector is
begin
   case scancode is
     when X"45"     => return X"0";
     when X"16"     => return X"1";
     when X"1E"     => return X"2";
     when X"26"     => return X"3";
     when X"25"     => return X"4";
     when X"2E"     => return X"5";
     when X"36"     => return X"6";
     when X"3D"     => return X"7";
     when X"3E"     => return X"8";
     when X"46"     => return X"9";
     when X"AA"     => return X"A";
     when X"F0"     => return X"B";
     when others    => return X"F";
   end case;
end scanCodeToBCD;

-- TODO: parity check
function checkDataWord(word: in std_logic_vector(dataWord'HIGH downto 0))
    return boolean is
begin
    if word(0)  /= '0' then return false; end if; -- start bit
    if word(10) /= '1' then return false; end if; -- stop bit
    
    return true;
end checkDataWord;

begin

READ : process(sysclk)

begin
    if rising_edge(sysclk) then
        -- push new PS/2 data into the buffers
        clkBuffer           <= PS2Clk & clkBuffer(3 downto 1);
        dataBuffer          <= PS2Data & dataBuffer(2 downto 1);

        keyPressed          <= '0'; -- reset key pressed state
        
        if clkBuffer(clkBuffer'LOW+1) = '0' and
           clkBuffer(clkBuffer'LOW+1) /= clkBuffer(clkBuffer'LOW)
           then
                dataWord(wordIndex)  <= dataBuffer(dataBuffer'LOW);
                wordIndex           <= wordIndex +1;
        
                -- check if we're at the end of the data frame
                if wordIndex >= dataWord'HIGH then
                    wordIndex       <= 0;
                    
                    -- check whether the data frame is valid
                    if checkDataWord(dataWord) then
                        keyData     <= scancodeToBCD(dataWord(dataWord'HIGH-2 
                                                              downto dataWord'LOW+1));
                    else
                        keyData     <= X"E"; -- error, integrity check failed
                    end if; -- checkDataWord
                    keyPressed      <= '1';
--                    dataWord        <= (others => '0');
                end if; -- wordIndex = 11
        end if; -- "falling edge" clkBuffer
    end if; -- rising_edge(sysclk)
    
end process READ;



end Behavioral;
