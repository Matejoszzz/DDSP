library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- The Entity for a Testbench is always empty
entity tb_Ass1 is
end tb_Ass1;

architecture Behavioral of tb_Ass1 is

    -- 1. Component Declaration (The 'Map' of your Ass1 module)
    component Adder
        Port ( 
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            D : out STD_LOGIC_VECTOR (7 downto 0);
            CarryIn : in STD_LOGIC;
            CarryOut : out STD_LOGIC
        );
    end component;

    -- 2. Local Signals (The 'Wires' to connect things)
    signal A_top : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B_top : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal D_top : STD_LOGIC_VECTOR(7 downto 0);
    signal CarryIn_top : STD_LOGIC;
    signal Carryout_top : STD_LOGIC
    ;

begin

    -- 3. Instantiate the Unit Under Test (UUT)
    uut: Adder port map (
          A => A_top,
          B => B_top,
          D => D_top,
          CarryIn => CarryIn_top,
          CarryOut => CarryOut_top
        );

    -- 4. Stimulus Process (Your actual test instructions)
    stim_proc: process
    begin		
        -- Step 1: Set inputs to zero
        A_top <= "00000000";
        B_top <= "00000000";
        CarryIn_top <= '0';
        wait for 50 ns;
        

        A_top <= "01010101";
        B_top <= "11111111";
        wait for 50 ns;	        
        CarryIn_top <= '1';
        wait for 50 ns;	

        A_top <= "10101010";
        B_top <= "10101010";
        CarryIn_top <= '0';
        wait for 50 ns;
        CarryIn_top <= '1';
        wait for 50 ns;	

        -- Step 2: Change inputs
        A_top <= "11111111";
        B_top <= "11110000";
        wait for 50 ns;

        -- Finish simulation
        wait;
    end process;

end Behavioral;