library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity register_file is
	port(
		clk				: in std_logic;
		reset 			: in std_logic;
		write_enable	: in std_logic;
		wr_data			: in std_logic_vector(31 downto 0);
		wr_addr			: in std_logic_vector(3 downto 0);
		rd_addr1		: in std_logic_vector(3 downto 0);
		rd_addr2		: in std_logic_vector(3 downto 0);
		pc_enable	    : in std_logic;
        pc_data         : in std_logic_vector(31 downto 0);

		rd_data1		: out std_logic_vector(31 downto 0);
		rd_data2		: out std_logic_vector(31 downto 0);
		pc_out			: out std_logic_vector(31 downto 0)
	);

end register_file;

architecture behavioral of register_file is

	signal registers	: std_logic_vector(511 downto 0) := (others => '0') ;
    signal rd_reg1      : natural := 0;
    signal rd_reg2      : natural := 0;
    signal wr_reg       : natural := 0;

begin

    process(clk,reset)
    begin
    
        if(reset='1') then
            registers(511 downto 0) <= (others => '0') ;
        end if;
        
        if(clk='1') then
            rd_reg1 <= to_integer(unsigned(rd_addr1(3 downto 0)));
            rd_reg2 <= to_integer(unsigned(rd_addr2(3 downto 0)));
            wr_reg <= to_integer(unsigned(wr_addr(3 downto 0)));
            
            rd_data1(31 downto 0) <= registers((32*rd_reg1 + 31) downto (32*rd_reg1));
            rd_data2(31 downto 0) <= registers((32*rd_reg2 + 31) downto (32*rd_reg2));
            pc_out(31 downto 0) <= registers(511 downto 480);
            
            if(write_enable = '1') then
                registers((32*wr_reg + 31) downto (32*wr_reg)) <= wr_data(31 downto 0);
            end if;
            
            if(pc_enable = '1') then
                registers(511 downto 480) <= pc_data(31 downto 0);
            end if;
            
        end if;
    
    end process;

end behavioral;