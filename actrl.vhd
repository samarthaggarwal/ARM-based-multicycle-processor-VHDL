----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2018 16:04:33
-- Design Name: 
-- Module Name: actrl - Behavioral
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

entity actrl is
  Port (
--    ins     :       in std_logic_vector(27 downto 21);     -- ins[27 - 21]
    ins     :       in std_logic_vector(3 downto 0);     -- ins[24 - 21]
--    clk     :       in std_logic;
    state   :       in integer;
    
    op      :       out std_logic_vector(3 downto 0)
   );
end actrl;

architecture Behavioral of actrl is

begin

    op <= ins when (state = 7 or state = 8 ) else
        "0010" when ( (state = 15 or state = 16) and ins(2) = '0' ) else
        "0100";


--process(clk)
--begin
--    if(clk'event and clk = '1') then
--        if(ins(27 downto 26) = "00" ) then      -- DP
--            op <= ins(24 downto 21);
--        elsif (ins(27 downto 26) = "01") then       -- DT
--            if(ins(23) = '1') then
--                op <= "0100";
--            else
--                op <= "0010";
--            end if;
--        elsif (ins(27 downto 26) = "10") then       -- branch
--            op <= "0100";
--        end if;
        
--    end if;
--end process;

end Behavioral;