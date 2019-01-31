----------------------------------------------------------------------------------
-- Engineer: Pelle van Gils
-- 
-- Create Date: 01/30/2019 10:50:49 PM
-- Module Name: sound - Behavioral
-- Project Name: 1-Sound
-- Description: 
--  Continuous playback of a sound fragment
--  stored in a ROM block.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sound is
  port ( 
    clk         : in  std_logic;
    PIN_MONO    : out std_logic
  );
end sound;

architecture Behavioral of sound is

-- the frequency of `clk` in Hz.
constant    clockFreq       : integer   := 100*(10**6); -- 100 MHz clock

-- characteristics of the ROM block
constant    sampleSize      : integer   := 8;           -- 8bit sample size
constant    sampleCount     : integer   := 6710;
constant    sampleFreq      : integer   := 8*(10**3);   -- 8kHz Sample frequency

-- signals for relaying data
signal      memAddr         : std_logic_vector(12 downto 0) := (others => '0');
signal      memData         : std_logic_vector(7 downto 0)  := (others => '0');

-- counter signals used for creating intevals
signal      pwmCounter      : integer   := 0;
signal      sampleCounter   : integer   := 0;

component blkMemBertErnie is
  port (
    clka    : in  std_logic;
    addra   : in  std_logic_vector(12 downto 0);
    douta   : out std_logic_vector(7 downto 0)
  );
end component blkMemBertErnie;


begin

-- Set audio output
setPwmAudioOut : process( clk )
begin
    if rising_edge(clk) then
        -- always increase the counter
        pwmCounter <= (pwmCounter + 1);
        
        -- determine the duty cycle
        if (pwmCounter >= unsigned(memData)) then
            PIN_MONO <= '0';
        end if;
        
        -- roll over to the next PWM pulse
        if (pwmCounter >= 2**sampleSize) then
            pwmCounter <= 0;
            PIN_MONO <= '1';
        end if;
    end if; -- rising_edge(clk)

end process setPwmAudioOut;

-- Get data for the current audio sample from ROM
setAudioSampleData : process( clk )
begin
    if rising_edge(clk) then
        -- always increase counter
        sampleCounter <= (sampleCounter + 1);

        -- get next sample data if needed
        if (sampleCounter >= (clockFreq / sampleFreq)) then
            sampleCounter <= 0;

            memAddr <= std_logic_vector(unsigned(memAddr) + 1);
            if (unsigned(memAddr) >= (sampleCount-1)) then -- samplecount-1 b/c index
                memAddr <= (others => '0');
            end if;
        end if;
    end if; -- rising_edge(clk)
    
end process setAudioSampleData;


MEM : blkMemBertErnie port map (
    clka    => clk,
    addra   => memAddr,
    douta   => memData);

end Behavioral;
