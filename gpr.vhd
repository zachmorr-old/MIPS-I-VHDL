library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GPR is
    Generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 6
    );
    Port ( 
        clk : in std_logic;
        wr_en : in std_logic;
        wr_addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        wr_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
        rd_addr_1 : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        rd_data_1 : out std_logic_vector(DATA_WIDTH-1  downto 0);
        rd_addr_2 : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        rd_data_2: out std_logic_vector(DATA_WIDTH-1  downto 0)
    );
end GPR;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package GPR_pkg is
    component GPR is
        Generic (
            DATA_WIDTH : integer := 32;
            ADDR_WIDTH : integer := 6
        );
        Port ( 
            clk : in std_logic;
            wr_en : in std_logic;
            wr_addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
            wr_data : in std_logic_vector(DATA_WIDTH-1  downto 0);
            rd_addr_1 : in std_logic_vector(ADDR_WIDTH-1 downto 0);
            rd_data_1 : out std_logic_vector(DATA_WIDTH-1  downto 0);
            rd_addr_2 : in std_logic_vector(ADDR_WIDTH-1 downto 0);
            rd_data_2: out std_logic_vector(DATA_WIDTH-1  downto 0)
        );
    end component;
end package;

architecture Behavioral of GPR is

    type memory is array(0 to 35) of std_logic_vector(DATA_WIDTH-1 downto 0); -- 32 GPR + HI + LO + PC + EPC
    signal registers : memory := (others => (others=>'0'));
    
begin

    rd_data_1 <= registers(to_integer(unsigned(rd_addr_1)));
    rd_data_2 <= registers(to_integer(unsigned(rd_addr_2)));

    process(clk)
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                if wr_addr > "000000" and wr_addr < "100100" then
                    registers(to_integer(unsigned(wr_addr))) <= wr_data;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
