library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_CONTROL is
    Port ( 
        opcode : in std_logic_vector(5 downto 0);
        func : in std_logic_vector(5 downto 0);
        alu_control : out std_logic_vector(3 downto 0)
    );
end ALU_CONTROL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ALU_CONTROL_pkg is
    component ALU_CONTROL is
        Port ( 
            opcode : in std_logic_vector(5 downto 0);
            func : in std_logic_vector(5 downto 0);
            alu_control : out std_logic_vector(3 downto 0)
        );
    end component;
end package;

architecture Behavioral of ALU_CONTROL is

    -- ALU CONTROL
    constant ADD_C  : std_logic_vector(alu_control'length-1 downto 0) := "0000";
    constant SUB_C  : std_logic_vector(alu_control'length-1 downto 0) := "0001";
    constant AND_C  : std_logic_vector(alu_control'length-1 downto 0) := "0010";
    constant OR_C   : std_logic_vector(alu_control'length-1 downto 0) := "0011";
    constant XOR_C  : std_logic_vector(alu_control'length-1 downto 0) := "0100";
    constant NOR_C  : std_logic_vector(alu_control'length-1 downto 0) := "0101";
    constant SLT_C  : std_logic_vector(alu_control'length-1 downto 0) := "0110";
    constant SLTU_C : std_logic_vector(alu_control'length-1 downto 0) := "0111";
    constant SLL_C  : std_logic_vector(alu_control'length-1 downto 0) := "1000";
    constant SRL_C  : std_logic_vector(alu_control'length-1 downto 0) := "1001";
    constant SRA_C  : std_logic_vector(alu_control'length-1 downto 0) := "1010";
    
    -- FUNCTIONS
    constant SLL_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "000000";
    constant SRL_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "000010";
    constant SRA_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "000011";
    constant SLLV_FUNCTION : std_logic_vector(func'length-1 downto 0) := "000100";
    constant SRLV_FUNCTION : std_logic_vector(func'length-1 downto 0) := "000110";
    constant SRAV_FUNCTION : std_logic_vector(func'length-1 downto 0) := "000111";
    constant ADD_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "100000";
    constant ADDU_FUNCTION : std_logic_vector(func'length-1 downto 0) := "100001";
    constant SUB_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "100010";
    constant SUBU_FUNCTION : std_logic_vector(func'length-1 downto 0) := "100011";
    constant AND_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "100100";
    constant OR_FUNCTION   : std_logic_vector(func'length-1 downto 0) := "100101";
    constant XOR_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "100110";
    constant NOR_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "100111";
    constant SLT_FUNCTION  : std_logic_vector(func'length-1 downto 0) := "101010";
    constant SLTU_FUNCTION : std_logic_vector(func'length-1 downto 0) := "101011"; 
    
    -- OPCODES
    constant ADDI_OPCODE   : std_logic_vector(func'length-1 downto 0) := "001000";
    constant ADDIU_OPCODE  : std_logic_vector(func'length-1 downto 0) := "001001";
    constant SLTI_OPCODE   : std_logic_vector(func'length-1 downto 0) := "001010";
    constant SLTIU_OPCODE  : std_logic_vector(func'length-1 downto 0) := "001011";
    constant ANDI_OPCODE   : std_logic_vector(func'length-1 downto 0) := "001100";
    constant ORI_OPCODE    : std_logic_vector(func'length-1 downto 0) := "001101";
    constant XORI_OPCODE   : std_logic_vector(func'length-1 downto 0) := "001110";
    constant LUI_OPCODE    : std_logic_vector(func'length-1 downto 0) := "001111";
    
begin
    process(opcode, func)
    begin
        if opcode = "00000" then
            case func is
                when SLL_FUNCTION  =>
                    alu_control <= SLL_C; 
                when SRL_FUNCTION =>
                    alu_control <= SRL_C;
                when SRA_FUNCTION => 
                    alu_control <= SRA_C;
                when SLLV_FUNCTION => 
                    alu_control <= SLL_C; 
                when SRLV_FUNCTION =>
                    alu_control <= SRL_C;
                when SRAV_FUNCTION => 
                    alu_control <= SRA_C; 
                when ADD_FUNCTION =>
                    alu_control <= ADD_C; 
                when ADDU_FUNCTION =>
                    alu_control <= ADD_C; 
                when SUB_FUNCTION =>
                    alu_control <= SUB_C; 
                when SUBU_FUNCTION =>
                    alu_control <= SUB_C; 
                when AND_FUNCTION =>
                    alu_control <= AND_C; 
                when OR_FUNCTION =>
                    alu_control <= OR_C; 
                when XOR_FUNCTION =>
                    alu_control <= XOR_C;
                when NOR_FUNCTION =>
                    alu_control <= NOR_C; 
                when SLT_FUNCTION =>
                    alu_control <= SLT_C;
                when SLTU_FUNCTION =>
                    alu_control <= SLTU_C;
                when others =>
                    alu_control <= ADD_C;
            end case;
        else
            case opcode is
                when ADDI_OPCODE => 
                    alu_control <= ADD_C;
                when ADDIU_OPCODE =>
                    alu_control <= ADD_C; 
                when SLTI_OPCODE =>
                    alu_control <= SLT_C; 
                when SLTIU_OPCODE => 
                    alu_control <= SLTU_C; 
                when ANDI_OPCODE =>
                    alu_control <= AND_C;
                when ORI_OPCODE => 
                    alu_control <= OR_C; 
                when XORI_OPCODE => 
                    alu_control <= XOR_C;
                when LUI_OPCODE => 
                    alu_control <= ADD_C; --TODO
                when others =>
                    alu_control <= ADD_C;
            end case;
        end if;
    end process;
end Behavioral;
