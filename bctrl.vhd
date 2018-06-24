----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2018 16:04:33
-- Design Name: 
-- Module Name: bctrl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bctrl is
  Port ( 
    z   :   in std_logic;
    n   :   in std_logic;
    c   :   in std_logic;
    v   :   in std_logic;
    ins :   in std_logic_vector(3 downto 0); --ins[31 - 28]
    --clk : in std_logic;
    
    p   :   out std_logic
  );
end bctrl;

architecture Behavioral of bctrl is

begin

    p <= z when ins = "0000" else
        not z when ins = "0001" else
        c when ins = "0010" else
        not c when ins = "0011" else
        n when ins = "0100" else
        not n when ins = "0101" else
        v when ins = "0110" else
        not v when ins = "0111" else
        c and (not z) when ins = "1000" else
        not (c and (not z) ) when ins = "1001" else
        v xnor n when ins = "1010" else
        v xor n  when ins = "1011" else
        (v xnor n) and (not z) when ins = "1100" else
        not ((v xnor n) and (not z)) when ins = "1101" else
        '1';
         

--process(clk)
--begin
--    if(clk'event and clk = '1') then
--        case ins is
--            when "0000" => p <= z ;
--            when "0001" => p <= not z ;
--            when "0010" => p <= c ;
--            when "0011" => p <= not c ;
--            when "0100" => p <= n ;
--            when "0101" => p <= not n ;
--            when "0110" => p <= v ;
--            when "0111" => p <= not v ;
--            when "1000" => p <= c and (not z) ;
--            when "1001" => p <= not (c and (not z) ) ;
--            when "1010" => p <= v xnor n ;
--            when "1011" => p <= v xor n ;
--            when "1100" => p <= (v xnor n) and (not z) ;
--            when "1101" => p <= not ((v xnor n) and (not z)) ;
--            when others => p <= '1' ;
     
--        end case;
--    end if;        
--end process;

end Behavioral;
