----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2018 19:26:59
-- Design Name: 
-- Module Name: slave_interface - Behavioral
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

entity slave_interface_ssd is
    Port ( hsel : in STD_LOGIC;
           haddr : in STD_LOGIC_VECTOR (31 downto 0);
           hwrite : in STD_LOGIC;
           hsize : in STD_LOGIC_VECTOR (2 downto 0);
           htrans : in STD_LOGIC_VECTOR (1 downto 0);
           hready : in STD_LOGIC :='1';
           hwdata : in STD_LOGIC_VECTOR (31 downto 0);
           hreset : in STD_LOGIC :='0';
           hclk : in STD_LOGIC;
           hreadyout : out STD_LOGIC;
           hrdata : out STD_LOGIC_VECTOR (31 downto 0));
end slave_interface_ssd;

architecture Behavioral of slave_interface_ssd is

signal clk2 : std_logic;
signal count : natural;

signal state : integer :=0;
    -- 0 : idle htrans
    -- 1 : portselect
    -- 2 : hwrite
    -- 3 : switches

signal portselected : std_logic;
signal led : STD_LOGIC_VECTOR (16 downto 0);

begin

process(hclk)
begin

    count <= (count+1) mod 3;
    if(count=0) then
        clk2 <= not clk2;
    end if;

end process;


process(clk2)
begin

    if(state=0) then
    
        if(htrans="00") then
            state <= 1;
        else
            state <= 0;
        end if;
            
    elsif(state=1) then
                
        if(portselected='1') then
            state <= 2;
        else
            state <= 0;
        end if;
        
    elsif(state=2) then
                        
        if(hwrite='1') then
            state <= 3;
        else
            state <= 0;
        end if;
        
    elsif(state=5) then
                   
        led <= hwdata(15 downto 0);                       
        state <= 0;
            
    end if;

end process;

end Behavioral;
