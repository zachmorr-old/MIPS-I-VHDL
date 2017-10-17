library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0);
        control : in std_logic_vector (3 downto 0);
        result : out std_logic_vector(31 downto 0);
        zero : out std_logic;
        overflow : out std_logic
    );
end ALU;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ALU_pkg is
    component ALU is
        Port (
            a : in std_logic_vector(31 downto 0);
            b : in std_logic_vector(31 downto 0);
            control : in std_logic_vector (3 downto 0);
            result : out std_logic_vector(31 downto 0);
            zero : out std_logic;
            overflow : out std_logic
        );
    end component;
end package;


architecture Behavioral of ALU is
    -- ALU Control Signals
    constant ADD_C  : std_logic_vector(control'range) := "0000";
    constant SUB_C  : std_logic_vector(control'range) := "0001";
    constant AND_C  : std_logic_vector(control'range) := "0010";
    constant OR_C   : std_logic_vector(control'range) := "0011";
    constant XOR_C  : std_logic_vector(control'range) := "0100";
    constant NOR_C  : std_logic_vector(control'range) := "0101";
    constant SLT_C  : std_logic_vector(control'range) := "0110";
    constant SLTU_C : std_logic_vector(control'range) := "0111";
    constant SLL_C  : std_logic_vector(control'range) := "1000";
    constant SRL_C  : std_logic_vector(control'range) := "1001";
    constant SRA_C  : std_logic_vector(control'range) := "1010";
    
    -- Constant to compare to
    constant zeros  : std_logic_vector(result'range) := (others=>'0');
    
    -- Signals are 1 bit larger than a, b, & result to account for overflow
    signal a_u : unsigned(a'length downto 0) := (others=>'0');
    signal b_u : unsigned(a'length downto 0) := (others=>'0');
    signal a_s : signed(b'length downto 0) := (others=>'0');
    signal b_s : signed(b'length downto 0) := (others=>'0');
    signal result_i : std_logic_vector(result'length downto 0) := (others=>'0');
    signal overflow_i : std_logic := '0';
    
begin
    
    a_u <= '0' & unsigned(a);
    b_u <= '0' & unsigned(b);
    a_s <= a(a'high) & signed(a);
    b_s <= b(b'high) & signed(b);
    
    result <= result_i(result'range);
    zero <= '1' when (result_i(result'range) = zeros) else '0';
    overflow <= result_i(result_i'high); 
    
    process(a_u,b_u,a_s,b_s,control)
    begin
        case control is
            when ADD_C =>
                result_i <= std_logic_vector(a_u + b_u);
            when SUB_C =>
                result_i <= std_logic_vector(a_u - b_u);
            when AND_C =>
                result_i <= std_logic_vector(a_u and b_u);
            when OR_C =>
                result_i <= std_logic_vector(a_u or b_u);
            when XOR_C =>
                result_i <= std_logic_vector(a_u xor b_u); 
            when NOR_C =>
                result_i <= '0' & std_logic_vector(a_u(a'range) nor b_u(b'range)); -- Upper bits are alway 0, must ignore
            when SLT_C =>                                                          -- them or overflow bit will assert
                if a_s < b_s then
                    result_i <= (result'range=>'1', others=>'0');
                else
                    result_i <= (others=>'0');
                end if;
            when SLTU_C =>
                if a_u < b_u then
                    result_i <= (result'range=>'1', others=>'0');
                else
                    result_i <= (others=>'0');
                end if;
            when SLL_C =>
                result_i <= std_logic_vector(a_u sll to_integer(b_u));
            when SRL_C =>
                result_i <= std_logic_vector(a_u srl to_integer(b_u));
            when SRA_C =>
                result_i <= (others=>'0'); -- TODO
            when others =>
                result_i <= (others=>'0');
        end case;
    end process;
end Behavioral;
