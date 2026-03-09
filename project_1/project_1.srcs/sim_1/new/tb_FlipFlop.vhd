library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Used for the loop counter

entity tb_FlipFlop is
-- Testbenches have no ports
end tb_FlipFlop;

architecture Behavioral of tb_FlipFlop is
    -- Component Declaration
    component FlipFlop
        Port ( clk     : in  STD_LOGIC;
               dataIn  : in  STD_LOGIC;
               reset   : in  STD_LOGIC;
               preset  : in  STD_LOGIC;
               dataOut : out STD_LOGIC);
    end component;

    -- Signals to connect to the UUT (Unit Under Test)
    signal clk     : STD_LOGIC := '0';
    signal dataIn  : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal preset  : STD_LOGIC := '0';
    signal dataOut : STD_LOGIC;

    -- Clock period definition
    constant clk_period : time := 20 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: FlipFlop port map (
          clk => clk,
          dataIn => dataIn,
          reset => reset,
          preset => preset,
          dataOut => dataOut
        );

    -- Clock process: Repeats every 20ns 
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process: Tests all 8 combinations 
    stim_proc: process
    begin		
        -- Loop through 8 combinations (000 to 111)
        -- bits: reset, preset, dataIn
        for i in 0 to 7 loop
            (reset, preset, dataIn) <= std_logic_vector(to_unsigned(i, 3));
            wait for 20 ns;
        end loop;

        -- Return to a stable state
        reset <= '0';
        preset <= '0';
        wait;
    end process;

end Behavioral;