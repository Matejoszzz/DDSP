library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--*************************************************************** FlipFlop
entity FlipFlop is
    Port ( 
        clk     : in  STD_LOGIC;
        dataIn  : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        preset  : in  STD_LOGIC;
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

--*************************************************************** Register
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    Port (
        input  : in  STD_LOGIC_VECTOR (7 downto 0);
        output : out STD_LOGIC_VECTOR (7 downto 0);
        update : in  STD_LOGIC
    );
end reg;

architecture Behavioral of reg is
begin
    process(update)
    begin
        if rising_edge(update) then 
            output <= input;
        end if;
    end process;
end Behavioral;

--*************************************************************** DataFlow
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Updated DataFlow Port (11 downto 0 now)
entity CPU is
    Port ( 
        clk          : in  STD_LOGIC;
        input1       : in  STD_LOGIC_VECTOR (7 downto 0);
        input2       : in  STD_LOGIC_VECTOR (7 downto 0);
        instructions : in  STD_LOGIC_VECTOR (11 downto 0); -- Extra bit for preset
        CPU_out_A, CPU_out_B, CPU_out_C, CPU_out_D : out STD_LOGIC_VECTOR (7 downto 0);
        ALU_result   : out STD_LOGIC_VECTOR (7 downto 0);
        Carry_bit    : out STD_LOGIC
    );
end CPU;

architecture Structural of CPU is
    -- Components
    component Multiplexer
        Port (
            Selector   : in  STD_LOGIC_VECTOR (1 downto 0);
            In1, In2, In3, In4 : in STD_LOGIC_VECTOR (7 downto 0);
            someOutput : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component ALU
        Port ( 
            number1, number2 : in STD_LOGIC_VECTOR (7 downto 0);
            Cin      : in  STD_LOGIC;
            Operator : in  STD_LOGIC_VECTOR (1 downto 0);
            result   : out STD_LOGIC_VECTOR (7 downto 0);
            Cout     : out STD_LOGIC
        );
    end component;

    component reg
        Port ( input : in STD_LOGIC_VECTOR(7 downto 0); output : out STD_LOGIC_VECTOR(7 downto 0); update : in STD_LOGIC );
    end component;

    component FlipFlop
        Port ( clk, dataIn, reset, preset : in STD_LOGIC; dataOut : out STD_LOGIC );
    end component;

    -- Internal Signals
    signal mux1out : STD_LOGIC_VECTOR(7 downto 0);
    signal ALU_fb  : STD_LOGIC_VECTOR(7 downto 0);
    
    -- Register Signals
    signal Aen, Ben, Cen, Den : STD_LOGIC;
    signal updateA, updateB, updateC, updateD : STD_LOGIC;
    signal regA_out, regB_out, regC_out, regD_out : STD_LOGIC_VECTOR(7 downto 0);
    
    -- ALU/Carry Signals
    signal ALU_src1, ALU_src2 : STD_LOGIC_VECTOR(7 downto 0);
    signal carry_to_ALU   : STD_LOGIC;
    signal carry_from_ALU : STD_LOGIC;

begin

    -- 1. Decoder Logic (Destination Select)
    Aen <= '1' when instructions(5 downto 4) = "00" else '0';
    Ben <= '1' when instructions(5 downto 4) = "01" else '0';
    Cen <= '1' when instructions(5 downto 4) = "10" else '0';
    Den <= '1' when instructions(5 downto 4) = "11" else '0';

    -- Gated Update signals (Single pin control for registers)
    updateA <= clk and Aen;
    updateB <= clk and Ben;
    updateC <= clk and Cen;
    updateD <= clk and Den;

    -- 2. Input Selection Mux
    InputMux: Multiplexer port map (
        In1 => input1, In2 => input2, In3 => ALU_fb, In4 => "00000000",
        Selector => instructions(7 downto 6), someOutput => mux1out
    );

    -- 3. Registers
    RegisterA: reg port map (input => mux1out, output => regA_out, update => updateA);
    RegisterB: reg port map (input => mux1out, output => regB_out, update => updateB);
    RegisterC: reg port map (input => mux1out, output => regC_out, update => updateC);
    RegisterD: reg port map (input => mux1out, output => regD_out, update => updateD);

    -- 4. ALU Source Muxes
    ALU_Mux1: Multiplexer port map (
        In1 => regA_out, In2 => regB_out, In3 => regC_out, In4 => regD_out,
        Selector => instructions(3 downto 2), someOutput => ALU_src1
    );
    ALU_Mux2: Multiplexer port map (
        In1 => regA_out, In2 => regB_out, In3 => regC_out, In4 => regD_out,
        Selector => instructions(1 downto 0), someOutput => ALU_src2
    );

    -- 5. ALU and Carry Logic
    CarryReg: FlipFlop port map (
        clk     => clk,
        dataIn  => carry_from_ALU,
        reset   => instructions(10),
        preset  => instructions(11), -- CU will set this to '1' for ADD+1
        dataOut => carry_to_ALU
    );

    ALU_block: ALU port map (
        number1  => ALU_src1,
        number2  => ALU_src2,
        Cin      => carry_to_ALU,     -- From FlipFlop
        Operator => instructions(9 downto 8),
        result   => ALU_fb,
        Cout     => carry_from_ALU    -- To FlipFlop
    );

    -- 6. Output Assignments
    CPU_out_A <= regA_out;
    CPU_out_B <= regB_out;
    CPU_out_C <= regC_out;
    CPU_out_D <= regD_out;
    ALU_result <= ALU_fb;
    Carry_bit <= carry_to_ALU;

end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( 
        opcode       : in  STD_LOGIC_VECTOR(3 downto 0);
        control_word : out STD_LOGIC_VECTOR(11 downto 0);
        halt         : out STD_LOGIC
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(opcode)
    begin
        halt <= '0';
        case opcode is
            -- FORMAT: [Preset][Reset][ALU_Op(2)][Src_Mux(2)][Dest(2)][S1(2)][S2(2)]
            
            -- Loads (From Input1)
            when "0000" => control_word <= "000000000000"; -- LOAD A
            when "0001" => control_word <= "000000010000"; -- LOAD B
            when "0010" => control_word <= "000000100000"; -- LOAD C
            when "0011" => control_word <= "000000110000"; -- LOAD D
            
            -- Arithmetic (A = A op B)
            when "0100" => control_word <= "001110000001"; -- ADD AAB
            when "0110" => control_word <= "000110000001"; -- AND AAB
            when "1000" => control_word <= "001010000001"; -- OR  AAB
            when "1010" => control_word <= "000010000000"; -- NOT AA
            
            -- Arithmetic (C = C op D)
            when "0101" => control_word <= "001110101011"; -- ADD CCD
            when "0111" => control_word <= "000110101011"; -- AND CCD
            when "1001" => control_word <= "001010101011"; -- OR  CCD
            when "1011" => control_word <= "000010101010"; -- NOT CC
            
            -- Special: A = A + B + 1 (Use Preset!)
            when "1110" => control_word <= "101110000001"; -- Preset=1, ADD, FB->A
            
            when "1111" => halt <= '1'; control_word <= (others => '0');
            when others => halt <= '0'; control_word <= (others => '0');
        end case;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Program Counter
entity PC is
    Port ( clk, reset, halt : in STD_LOGIC; addr : out STD_LOGIC_VECTOR(3 downto 0));
end PC;

architecture Behavioral of PC is
    signal count : unsigned(3 downto 0) := "0000";
begin
    process(clk, reset) begin
        if reset = '1' then count <= "0000";
        elsif rising_edge(clk) and halt = '0' then count <= count + 1;
        end if;
    end process;
    addr <= std_logic_vector(count);
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Instruction ROM
entity ROM is
    Port ( addr : in STD_LOGIC_VECTOR(3 downto 0); opcode : out STD_LOGIC_VECTOR(3 downto 0));
end ROM;

architecture Behavioral of ROM is
    type rom_array is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    constant program : rom_array := (
        "0000", "0001", "1110", "1111", others => "1111" -- Load A, Load B, ADD+1, Halt
    );
begin
    opcode <= program(to_integer(unsigned(addr)));
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Computer_System is
    Port ( 
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        in1    : in  STD_LOGIC_VECTOR (7 downto 0);
        in2    : in  STD_LOGIC_VECTOR (7 downto 0);
        outA   : out STD_LOGIC_VECTOR (7 downto 0) -- For monitoring
    );
end Computer_System;

architecture Structural of Computer_System is
    signal sys_addr   : STD_LOGIC_VECTOR(3 downto 0);
    signal sys_opcode : STD_LOGIC_VECTOR(3 downto 0);
begin

    CPU_Inst: entity work.CPU 
        port map (
            clk => clk, reset => reset, input1 <= in1, input2 <= in2,
            ROM_opcode => sys_opcode,
            ROM_addr   => sys_addr,
            regA => outA, regB => open, regC => open, regD => open,
            ALU_out => open, Carry => open
        );

    ROM_Inst: entity work.ROM 
        port map (
            addr => sys_addr,
            opcode => sys_opcode
        );

end Structural;