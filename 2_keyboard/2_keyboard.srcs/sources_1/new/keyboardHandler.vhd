----------------------------------------------------------------------------------
-- Engineer: Pelle van Gils
-- 
-- Create Date: 02/09/2019 12:10:46 AM
-- Module Name: keyboardHandler - Behavioral
-- Project Name: 2_keyboard
-- Description: 
--  PS/2 keyboard reader
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--   needs VHDL2008
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
signal  clkBuffer   : std_logic_vector(3 downto 0)  := (others => '1');
signal  dataBuffer  : std_logic_vector(2 downto 0)  := (others => '1');

-- 11-bit word as sent by the PS/2 device
signal  dataWord    : std_logic_vector(10 downto 0) := (others => '0');
signal  wordIndex   : integer := 0;

-- key-up events need to be ignored. The scancode after a key-up code (F0)
-- will be dropped if `dropNextKey` is set
signal  dropNextKey : boolean := false;

-- bcd that signals a key-up event
constant    KEY_UP  : std_logic_vector(3 downto 0)  := X"B";
-- bcd: ERROR: integrity check failed
constant    BCD_ERR : std_logic_vector(3 downto 0)  := X"E";


-- Trancode an 8-bit scancode to a corresponding 4-bit BCD value.
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

-- Check the integrity of a PS/2 dataframe.
-- checks for start + stop bits and parity.
function checkDataWord(word: in std_logic_vector(dataWord'HIGH downto 0))
    return boolean is
begin
    if word(word'LOW)       /= '0' then return false; end if; -- start bit
    if word(word'HIGH)      /= '1' then return false; end if; -- stop bit
    
    -- parity check. The PS/2 dataframe uses _odd_ parity. Including the parity bit
    -- D0-D7+P should contain an odd number of '1's
    if (xor word(word'HIGH-1 downto word'LOW+1)) /= '1' then return true; end if;

    return true;
end checkDataWord;

begin

READ : process(sysclk)

variable newBCD         : std_logic_vector(3 downto 0);
variable dropKey        : boolean;

begin
    if rising_edge(sysclk) then
        -- push new PS/2 data into the buffers
        clkBuffer           <= PS2Clk & clkBuffer(clkBuffer'HIGH downto 1);
        dataBuffer          <= PS2Data & dataBuffer(dataBuffer'HIGH downto 1);

        keyPressed          <= '0'; -- reset key pressed state
        
        -- get PS2 data-bit on a 'falling edge' of the PS2 clock
        if clkBuffer(clkBuffer'LOW+1) = '0' and
           clkBuffer(clkBuffer'LOW+1) /= clkBuffer(clkBuffer'LOW)
           then
                dataWord(wordIndex) <= dataBuffer(dataBuffer'LOW);
                wordIndex           <= wordIndex +1;
        end if;

        -- check if we're at the end of the data frame
        if wordIndex > dataWord'HIGH then
            wordIndex       <= 0;

            -- if the data frame is valid; get the key data from it.
            if checkDataWord(dataWord) then
                newBCD      := scancodeToBCD(dataWord(dataWord'HIGH-2
                                                      downto dataWord'LOW+1));
            else
                newBCD      := BCD_ERR; -- error, integrity check failed
            end if; -- checkDataWord

            -- check for a key-up event. on key-release the PS/2 keyboard
            -- sends a KEY_UP byte followed by the pressed key's scancode.
            dropKey     := dropNextKey or newBcd = KEY_UP;
            dropNextKey <= newBcd = KEY_UP;
            keyData     <= newBCD;
            
            if not dropKey then
                keyPressed  <= '1';
                dataWord    <= (others => '0');
            end if; -- dropKey
        end if; -- wordIndex = 11
    end if; -- rising_edge(sysclk)
    
end process READ;



end Behavioral;
