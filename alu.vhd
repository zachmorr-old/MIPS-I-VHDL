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

    signal a_u : unsigned(31 downto 0) := (others=>'0');
    signal b_u : unsigned(31 downto 0) := (others=>'0');
    signal r : unsigned(31 downto 0) := (others=>'0');

begin
    
    result <= std_logic_vector(r);
    a_u <= unsigned(a);
    b_u <= unsigned(b);
    zero <= '0' when (r = x"00000000");
    
    process(a,b,control)
    begin
        case control is
            when "0000" => -- ADD
                r <= a_u + b_u;
            when "0001" => -- ADDU
                --TODO
            when "0010" => -- SUB
                r <= a_u - b_u;
            when "0011" => -- SUBU
                --TODO
            when "0100" => -- AND
                r <= a_u and b_u;
            when "0101" => -- OR
                r <= a_u or b_u;
            when "0110" => -- XOR
                --TODO  
            when "0111" => -- NOR
                --TODO
            when "1000" => -- SLT
                if a < b then
                    r <= x"FFFFFFFF";
                else
                    r <= x"00000000";
                end if;
            when "1001" => -- SLTU
                --TODO
            when others =>
                r <= a_u + b_u;
        end case;
    end process control;
end Behavioral;
