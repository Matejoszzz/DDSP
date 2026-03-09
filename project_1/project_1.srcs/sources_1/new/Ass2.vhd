library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlop is
    Port ( clk : in STD_LOGIC;
       dataIn : in STD_LOGIC;
       reset : in STD_LOGIC;
       preset : in STD_LOGIC;
       dataOut : out STD_LOGIC
    );
end FlipFlop;

architecture Behavioral of FlipFlop is

begin
    process(clk, reset, preset)
begin
    if reset = '1' then 
        dataOut <= '0';
        
    elsif preset = '1' then 
        dataOut <= '1';
        
    elsif rising_edge(clk) then 
        dataOut <= dataIn; 
        
    end if;
end process;
end Behavioral;
