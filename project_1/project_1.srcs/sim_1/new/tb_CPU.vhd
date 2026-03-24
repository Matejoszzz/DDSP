library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_tb is
end CPU_tb;

architecture Behavioral of CPU_tb is
    component CPU
        Port ( 
            clk          : in  STD_LOGIC;
            input1, input2 : in STD_LOGIC_VECTOR (7 downto 0);
            instructions : in  STD_LOGIC_VECTOR (10 downto 0);
            CPU_out_A, CPU_out_B, CPU_out_C, CPU_out_D : out STD_LOGIC_VECTOR (7 downto 0);
            ALU_result   : out STD_LOGIC_VECTOR (7 downto 0);
            Carry_bit    : out STD_LOGIC
        );
    end component;

    signal clk          : STD_LOGIC := '0';
    signal input1       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal input2       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal instructions : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
    signal outA, outB, outC, outD, alu_res : STD_LOGIC_VECTOR(7 downto 0);
    signal carry : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin
    uut: CPU port map (clk, input1, input2, instructions, outA, outB, outC, outD, alu_res, carry);

    clk_process : process
    begin
        clk <= '0'; wait for clk_period/2;
        clk <= '1'; wait for clk_period/2;
    end process;

    stim_proc: process
    begin		
        -- Step 0: Clear Carry FlipFlop
        instructions(10) <= '1'; wait for clk_period;
        instructions(10) <= '0';

        -- OP 1: Load 50 (input1) into Reg A
        input1 <= "00110010"; instructions(7 downto 4) <= "0000"; wait for clk_period;

        -- OP 2: Load 25 (input2) into Reg B
        input2 <= "00011001"; instructions(7 downto 4) <= "0101"; wait for clk_period;

        -- OP 3: Load 10 (input1) into Reg C
        input1 <= "00001010"; instructions(7 downto 4) <= "0010"; wait for clk_period;

        -- OP 4: ADD A + B -> Reg D (50 + 25 = 75)
        -- Source=ALU(10), Dest=D(11), Op=Add(00), Src1=A(00), Src2=B(01)
        instructions <= "00010110001"; wait for clk_period;

        -- OP 5: SUB D - C -> Reg A (75 - 10 = 65)
        -- Source=ALU(10), Dest=A(00), Op=Sub(01), Src1=D(11), Src2=C(10)
        instructions <= "00110001110"; wait for clk_period;

        wait;
    end process;
end Behavioral;