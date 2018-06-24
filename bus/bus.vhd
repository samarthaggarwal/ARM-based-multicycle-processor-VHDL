----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2018 13:22:35
-- Design Name: 
-- Module Name: bus - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity myBus is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (15 downto 0);
           out_led : out STD_LOGIC_VECTOR (15 downto 0);
--           cathode : out STD_LOGIC_VECTOR (6 downto 0);
--           anode : out STD_LOGIC_VECTOR (3 downto 0);
           out_ssd : out STD_LOGIC_VECTOR (15 downto 0));
end myBus;

architecture Behavioral of myBus is

signal clk2 : std_logic;
signal count : natural;

signal in_memory : STD_LOGIC_VECTOR (15 downto 0);
signal out_memory : STD_LOGIC_VECTOR (15 downto 0);

signal read_add1 : STD_LOGIC_VECTOR(3 downto 0);
signal read_add2 : STD_LOGIC_VECTOR(3 downto 0);
signal write_add : STD_LOGIC_VECTOR(3 downto 0);


begin

--memory : entity work.memory
--    port map(
--        clk => clk,
--        read_add1 => read_add1, -- port 2 not used
--        write_add => write_add,
--        read_data => out_memory,
--        write_data => in_memory,
--        write_enable => 1
--    );

process(clk)
begin

    count <= (count+1) mod 3;
    if(count=0) then
        clk2 <= not clk2;
    end if;

end process;

process(clk2)
begin

    if(clk2='1' and clk'event) then
    
--        read_add <=  ;
--        write_add <=  ;
        in_memory <= input;
        
    
    end if;

end process;

out_led <= in_memory;
out_ssd <= out_memory;

end Behavioral;
