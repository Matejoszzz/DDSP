library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_CPU is
--  Port ( );
end tb_CPU;

architecture Behavioral of tb_CPU is
component CPU is
    Port ( input1, input2 : in STD_LOGIC_VECTOR (7 downto 0);
       aout, bout, cout, dout : out STD_LOGIC_VECTOR (7 downto 0);
       clk : in STD_LOGIC;
       instructions : in STD_LOGIC_VECTOR (7 downto 0)
       
    );
end component;
signal tomux1 : std_logic_vector (7 downto 0);
signal tomux2 : std_logic_vector (7 downto 0);

signal reg1out : std_logic_vector (7 downto 0);
signal reg2out : std_logic_vector (7 downto 0);
signal reg3out : std_logic_vector (7 downto 0);
signal reg4out : std_logic_vector (7 downto 0); 


signal instructions : std_logic_vector (7 downto 0);
signal clk: std_logic;

constant clk_period : time := 20 ns;
begin
uut: CPU port map (
input1 => tomux1,
input2 => tomux2,
aout => reg1out,
bout => reg2out,
cout => reg3out,
dout => reg4out,
clk => clk,
instructions => instructions
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
  
instructions <= "00000000";
tomux1 <= "00011000";
tomux2 <= "00000011";
wait for 50 ns;

instructions <= "00000000";
wait for 50 ns;
instructions <= "00010000";
wait for 150 ns;
instructions <= "00100000";
wait for 50 ns;
instructions <= "00110000";
wait for 50 ns;
wait;
   end process;
end Behavioral;
