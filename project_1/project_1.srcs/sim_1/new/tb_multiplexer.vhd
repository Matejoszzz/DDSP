library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- The Entity for a Testbench is always empty
entity tb_multiplexer is
end tb_multiplexer;

architecture Behavioral of tb_multiplexer is

    -- 1. Component Declaration (The 'Map' of your Ass1 module)
    component multiplexer
        Port ( 
            Selector : in STD_LOGIC_VECTOR (1 downto 0);
            In1 : in STD_LOGIC_VECTOR (7 downto 0);
            In2 : in STD_LOGIC_VECTOR (7 downto 0);
            In3 : in STD_LOGIC_VECTOR (7 downto 0);
            In4 : in STD_LOGIC_VECTOR (7 downto 0);
            SomeOutput : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component;

    -- 2. Local Signals (The 'Wires' to connect things)
    signal Sel : STD_LOGIC_VECTOR(1 downto 0);
    signal i1 : STD_LOGIC_VECTOR(7 downto 0);
    signal i2 : STD_LOGIC_VECTOR(7 downto 0);
    signal i3 : STD_LOGIC_VECTOR(7 downto 0);
    signal i4 : STD_LOGIC_VECTOR(7 downto 0);
    signal output : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- 3. Instantiate the Unit Under Test (UUT)
    uut: multiplexer port map (
          Selector => Sel,
          In1 => i1,
          In2 => i2,
          In3 => i3,
          In4 => i4,
          SomeOutput => output
        );


    stim_proc: process
    begin
        i1 <= "01100101";
        i2 <= "00100101";
        i3 <= "11111100";
        i4 <= "00110001";
        sel <= "00";
        wait for 50 ns;
        sel <= "01";
        wait for 50 ns;
        sel <= "10";
        wait for 50 ns;
        sel <= "11";
        wait for 50 ns;
        
        i1 <= "01110111";
        i2 <= "00000000";
        i3 <= "11000011";
        i4 <= "01111110";
        sel <= "00";
        wait for 50 ns;
        sel <= "01";
        wait for 50 ns;
        sel <= "10";
        wait for 50 ns;
        sel <= "11";
        wait for 50 ns;
        
        
        wait;
    end process;

end Behavioral;