library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Half_Adder is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CarryIn : in STD_LOGIC;
           D : out STD_LOGIC_VECTOR (7 downto 0);
           CarryOut : out STD_LOGIC
           );
end Half_Adder;

architecture Behavioral of Adder is
 signal C : STD_LOGIC_VECTOR (8 downto 0);
begin
    C <= ((A and B)
    or (B and C(7 downto 0)) 
    or (A and C(7 downto 0))) 
    & CarryIn;
    D <= (A xor B) xor C(7 downto 0);
    CarryOut <= C(8);

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer is
    Port ( Selector : in STD_LOGIC_VECTOR (1 downto 0);
        In1 : in STD_LOGIC_VECTOR (7 downto 0);
        In2 : in STD_LOGIC_VECTOR (7 downto 0);
        In3 : in STD_LOGIC_VECTOR (7 downto 0);
        In4 : in STD_LOGIC_VECTOR (7 downto 0);
        SomeOutput : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Multiplexer;

architecture Behavioral of Multiplexer is
    signal Mask1 : STD_LOGIC_VECTOR (7 downto 0);
    signal Mask2 : STD_LOGIC_VECTOR (7 downto 0);
    signal Mask3 : STD_LOGIC_VECTOR (7 downto 0);
    signal Mask4 : STD_LOGIC_VECTOR (7 downto 0);
begin
    Mask1 <= (others => (Selector(0) nor Selector(1)));
    Mask2 <= (others => (Selector(0) and not Selector(1)));
    Mask3 <= (others => (not Selector(0) and Selector(1)));
    Mask4 <= (others => (Selector(0) and Selector(1)));

    SomeOutput <= ((Mask1 and In1) or (Mask2 and In2) or (Mask3 and In3) or (Mask4 and In4));
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( 
        number1 : in STD_LOGIC_VECTOR (7 downto 0);
        number2 : in STD_LOGIC_VECTOR (7 downto 0);
        Cin : in STD_LOGIC;
        Operator : in STD_LOGIC_VECTOR (1 downto 0);
        result : out STD_LOGIC_VECTOR (7 downto 0);
        Cout : out STD_LOGIC
    );
end ALU;

architecture Structural of ALU is
    component Adder
        Port (
            A, B : in STD_LOGIC_VECTOR (7 downto 0);
            CarryIn : in STD_LOGIC;
            D : out STD_LOGIC_VECTOR (7 downto 0);
            CarryOut : out STD_LOGIC
        );
    end component;
    
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
    
    signal adderToMux : STD_LOGIC_VECTOR(7 downto 0);
    signal one : STD_LOGIC_VECTOR(7 downto 0);
    signal two : STD_LOGIC_VECTOR(7 downto 0);
    signal three : STD_LOGIC_VECTOR(7 downto 0);

begin

    one <= not number1;
    two <= number1 and number2;
    three <= number1 or number2;
    
    ADDER_BLOCK: Adder port map (
        A => number1,
        B => number2,
        CarryIn => Cin,
        D => adderToMux,
        CarryOut => Cout
    );
    
    MUX_BLOCK: Multiplexer port map (
        In1 => one, 
        In2 => two, 
        In3 => three, 
        In4 => adderToMux,
        Selector => Operator,
        someOutput => result 
    );
end Structural;