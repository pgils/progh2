----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2019 10:50:49 PM
-- Design Name: 
-- Module Name: sound - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity sound is
  port ( 
    clk         : in  std_logic;
    PIN_MONO    : out std_logic
  );
end sound;

architecture Behavioral of sound is

constant    clockFreq       : integer   := 100*(10**6); -- 100 MHz clock

constant    sampleSize      : integer   := 8;           -- 8bit sample size
constant    sampleCount     : integer   := 6710;
constant    sampleFreq      : integer   := 8*(10**3);   -- 8kHz Sample frequency

signal      memAddr         : std_logic_vector(12 downto 0);
signal      memData         : std_logic_vector(7 downto 0);

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

setPwmAudioOut : process( clk )
begin
    if rising_edge(clk) then
        pwmCounter <= (pwmCounter + 1);
        
        if (pwmCounter >= unsigned(memData)) then
            PIN_MONO <= '0';
        end if;
        
        if (pwmCounter >= sampleSize) then
            pwmCounter <= 0;
            PIN_MONO <= '1';
        end if;
    end if; -- rising_edge(clk)

end process setPwmAudioOut;

setAudioSampleData : process( clk )
begin
    if rising_edge(clk) then
        sampleCounter <= (sampleCounter + 1);
        
        if (sampleCounter >= (clockFreq / sampleFreq)) then
            memAddr <= std_logic_vector(unsigned(memAddr) + 1);
            if (unsigned(memAddr) >= sampleCount) then
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
