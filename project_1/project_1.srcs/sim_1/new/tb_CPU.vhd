library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_CPU is
--  Port ( );
end tb_CPU;

architecture Behavioral of tb_CPU is
component CPU is
    Port ( input1, input2 : in STD_LOGIC_VECTOR (7 downto 0);
       CPU_output1        : out STD_LOGIC_VECTOR ( 7 downto 0);
       clk                : in STD_LOGIC;
       instructions       : in STD_LOGIC_VECTOR (10 downto 0)
       
    );
end component;
signal tomux1 : std_logic_vector (7 downto 0);
signal tomux2 : std_logic_vector (7 downto 0);
signal CPU_output1 : std_logic_vector (7 downto 0);

signal instructions : std_logic_vector (10 downto 0);
signal clk: std_logic;

constant clk_period : time := 20 ns;
begin
uut: CPU port map (
input1 => tomux1,
input2 => tomux2,
clk => clk,
instructions => instructions,
CPU_output1 => CPU_output1
);

   clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
  stim_proc: process
  begin 
  --test case 1:
tomux1 <= x"05";
tomux2 <= x"03";
instructions <= "00000000000";
wait for 100 ns;  -- several clock cycles to make sure it loads

-- load input2 into register B  
instructions <= "00001010000";  -- bits 7-6="01" selects input2, bits 5-4="01" loads reg B
wait for 100 ns;

-- add reg A + reg B
instructions <= "01100000001";
wait for 500 ns;  -- hold long enough to see stable output
wait;
--instructions <= "01100000001";
--tomux1 <= x"05";  -- 5
--tomux2 <= x"03";  -- 

----tomux1 <= "00000000";
----tomux2 <= "00000001";
--wait for 50 ns;

--instructions <= "10000000000";
--wait for 50 ns;
--instructions <= "01000000000";
--wait for 150 ns;
--instructions <= "10000000000";
--wait for 50 ns;
--instructions <= "00000000000";
--wait for 50 ns;
--wait;
   end process;
end Behavioral;
