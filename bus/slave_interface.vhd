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

entity slave_interface_memory is
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
end slave_interface_memory;

architecture Behavioral of slave_interface_memory is

signal clk2 : std_logic;
signal count : natural;

signal state : integer :=0;
    -- 0 : idle htrans
    -- 1 : mem_select
    -- 2 : read add
    -- 3 : hready 0 1
    -- 4 : hready 0 2
    -- 5 : hready 1 3
    -- 6 : check w
    -- 7 : check hrdata = mem_out
    -- 8 : check we = 1

 
signal addr : STD_LOGIC_VECTOR (31 downto 0);
signal mem_out : STD_LOGIC_VECTOR (31 downto 0);
signal w : std_logic;

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

    if(clk2='1' and clk2'event) then
    
        if(state=0) then
            
            if(htrans="00") then
                state <= 1;
            else
                state <= 0;    
            end if;    
    
        elsif(state=1) then
            
            if(hsel='1') then
                state <= 2;
            else
                state <= 0;    
            end if; 
            
        elsif(state=2) then
        
            addr <= haddr;
            w <= hwrite;
            hreadyout <= '0';
            state <= 3; 
        
        elsif(state=3) then
        
            hreadyout <= '0';
            state <= 4; 
            
        elsif(state=4) then
        
            hreadyout <= '0';
            state <= 5;
        
        elsif(state=5) then
        
            hreadyout <= '1';
            state <= 6;
            
        elsif(state=6) then
                    
            if(w='1') then
                state <= 7;
            else
                state <= 8;    
            end if; 
            
        elsif(state=6) then
                                
            hrdata <= mem_out;
            state <= 0;
            
        elsif(state=6) then
                                    
            state <= 0;

        end if;
    
    end if;

end process;

end Behavioral;
