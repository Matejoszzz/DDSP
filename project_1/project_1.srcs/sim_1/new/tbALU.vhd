library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ALU is
-- Empty entity for testbench
end tb_ALU;

architecture Behavioral of tb_ALU is

    -- Component Declaration for the ALU
    component ALU
        Port ( 
            number1  : in  STD_LOGIC_VECTOR (7 downto 0);
            number2  : in  STD_LOGIC_VECTOR (7 downto 0);
            Cin      : in  STD_LOGIC;
            Operator : in  STD_LOGIC_VECTOR (1 downto 0);
            result   : out STD_LOGIC_VECTOR (7 downto 0);
            Cout     : out STD_LOGIC
        );
    end component;

    -- Local Signals to drive the ALU
    signal n1, n2   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal c_in     : STD_LOGIC := '0';
    signal op       : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal res      : STD_LOGIC_VECTOR(7 downto 0);
    signal c_out    : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ALU port map (
        number1  => n1,
        number2  => n2,
        Cin      => c_in,
        Operator => op,
        result   => res,
        Cout     => c_out
    );

    -- Stimulus Process
    stim_proc: process
    begin		
        -- Test Case 1: Invert A (Operator 00)
        n1 <= "00001111"; 
        op <= "00";
        wait for 100 ns;

        -- Test Case 2: A AND B (Operator 01)
        n1 <= "10101010";
        n2 <= "11110000";
        op <= "01";
        wait for 100 ns;

        -- Test Case 3: A OR B (Operator 10)
        op <= "10";
        wait for 100 ns;

        -- Test Case 4: Addition (Operator 11)
        n1 <= "00000010"; -- 2
        n2 <= "00000011"; -- 3
        c_in <= '0';
        op <= "11";
        wait for 100 ns;

        -- Test Case 5: Addition with Carry
        n1 <= "11111111"; -- 255
        n2 <= "00000001"; -- 1
        wait for 100 ns;

        wait; -- End of simulation
    end process;

end Behavioral;