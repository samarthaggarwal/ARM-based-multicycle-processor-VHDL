library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity memory is
	port(
		clk				: in std_logic;
		reset 			: in std_logic;
		write_enable	: in std_logic_vector(3 downto 0);
		wr_data			: in std_logic_vector(31 downto 0);
		addr			: in std_logic_vector(31 downto 0);
		rd_data		: out std_logic_vector(31 downto 0)
	);

end memory;

architecture behavioral of memory is

	signal registers	: std_logic_vector(32767 downto 0) := (others => '0') ;
    signal  reg      : natural := 0;

begin

    bram : entity work.BRAM_wrapper
  port map (
    BRAM_PORTA_addr => addr,
    BRAM_PORTA_clk => clk,
    BRAM_PORTA_din => wr_data,
    BRAM_PORTA_dout => rd_data,
    BRAM_PORTA_en => '1',
    BRAM_PORTA_rst => reset,
    BRAM_PORTA_we => write_enable
  );

--    process(clk,reset)
--    begin
    
--        if(reset='1') then
--            registers(32767 downto 0) <= (others => '0') ;
--        end if;
        
--        if(clk='1') then
--            reg <= to_integer(unsigned(addr(31 downto 0)));
            
--            rd_data(31 downto 0) <= registers((32*reg + 31) downto (32*reg));

--            if(write_enable(3) = '1') then
--                registers((32*reg + 31) downto (32*reg + 24)) <= wr_data(31 downto 24);
--            end if;
            
--            if(write_enable(2) = '1') then
--                registers((32*reg + 23) downto (32*reg + 16)) <= wr_data(23 downto 16);
--            end if;
            
--            if(write_enable(1) = '1') then
--                registers((32*reg + 15) downto (32*reg + 8)) <= wr_data(15 downto 8);
--            end if;
            
--            if(write_enable(0) = '1') then
--                registers((32*reg + 7) downto (32*reg)) <= wr_data(7 downto 0);
--            end if;
            
            
--        end if;
    
--    end process;

end behavioral;