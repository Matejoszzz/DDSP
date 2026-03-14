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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
       output : out STD_LOGIC_VECTOR (7 downto 0);
       decoder : in STD_LOGIC
    );
end reg;



architecture Behavioral of reg is

begin
    process(decoder)
begin
    if rising_edge(decoder) then 
        output <= input; 
        
    end if;
end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
    Port ( input1, input2 : in STD_LOGIC_VECTOR (7 downto 0);
       aout, bout, cout, dout : out STD_LOGIC_VECTOR (7 downto 0);
       clk : in STD_LOGIC;
       instructions : in STD_LOGIC_VECTOR (7 downto 0)
    );
end CPU;



architecture Structural of CPU is
    
    component Multiplexer
        Port (
        Selector : in STD_LOGIC_VECTOR (1 downto 0);
        In1 : in STD_LOGIC_VECTOR (7 downto 0);
        In2 : in STD_LOGIC_VECTOR (7 downto 0);
        In3 : in STD_LOGIC_VECTOR (7 downto 0);
        In4 : in STD_LOGIC_VECTOR (7 downto 0);
        SomeOutput : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
    component reg
     Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
       output : out STD_LOGIC_VECTOR (7 downto 0);
       decoder : in STD_LOGIC
    );
    end component;
    
    signal mux1out : STD_LOGIC_VECTOR(7 downto 0);
    
    signal Reg1out : STD_LOGIC_VECTOR(7 downto 0);
    signal Reg2out : STD_LOGIC_VECTOR(7 downto 0);
    signal Reg3out : STD_LOGIC_VECTOR(7 downto 0);
    signal Reg4out : STD_LOGIC_VECTOR(7 downto 0);
    
    signal extra1 : STD_LOGIC;
    signal extra2 : STD_LOGIC;
    signal extra3 : STD_LOGIC;
    signal extra4 : STD_LOGIC;
begin
extra4 <= (instructions(5) and instructions(4))and clk;
extra1 <= (not instructions(5) and not instructions(4))and clk;
extra2 <= (not instructions(5) and instructions(4))and clk;
extra3 <= (instructions(5) and not instructions(4))and clk;


InputMux_block: Multiplexer port map (
        In1 => input1, 
        In2 => input2,
        In3 => "00000000",
        In4 => "00000000",
        Selector => instructions (7 downto 6),
        someOutput => mux1out
);

RegisterA: reg port map (
        input => mux1out,
        output => aout,
        decoder => extra1
);
RegisterB: reg port map (
        input => mux1out,
        output => bout,
        decoder => extra2
);
RegisterC: reg port map (
        input => mux1out,
        output => cout,
        decoder => extra3
);
RegisterD: reg port map (
        input => mux1out,
        output => dout,
        decoder => extra4
);

  
end Structural;
