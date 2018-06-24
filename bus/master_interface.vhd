----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2018 19:23:54
-- Design Name: 
-- Module Name: master_interface - Behavioral
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

entity master_interface is
    Port ( hready : in STD_LOGIC :='1';
           hreset : in STD_LOGIC :='0';
           hclk : in STD_LOGIC;
           hrdata : in STD_LOGIC_VECTOR (31 downto 0);
           haddr : out STD_LOGIC_VECTOR (31 downto 0);
           hwrite : out STD_LOGIC;
           hsize : out STD_LOGIC_VECTOR (2 downto 0);
           htrans : out STD_LOGIC_VECTOR (1 downto 0);
           hwdata : out STD_LOGIC_VECTOR (31 downto 0));
end master_interface;

architecture Behavioral of master_interface is

signal clk2 : std_logic;
signal count : natural;

signal state : integer :=0;
    -- 0 : idle init
    -- 1 : read rd_add
    -- 2 : idle read wait
    -- 3 : read rd_data
    -- 4 : read wr_add
    -- 5 : idle write wait

signal base : std_logic_vector; 
signal dr : STD_LOGIC_VECTOR (31 downto 0);
signal b : STD_LOGIC_VECTOR (31 downto 0);

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
        
    
        elsif(state=1) then
            
            haddr <= base;
            htrans <= "00"; -- nonseq
            hwrite <= '0';
            hsize <= "010"; -- word
            
        elsif(state=2) then
        
            if(hready='1') then
                state <= 2;
            end if;
        
        elsif(state=3) then
        
            dr <= hrdata;
            
        elsif(state=4) then
        
            haddr <= base;
            htrans <= "00"; -- nonseq
            hwdata <= b;
            hwrite <= '1';
            hsize <= "010"; -- word
        
        elsif(state=5) then
        
            if(hready='1') then
                state <= 2;
            end if;

        end if;
    
    end if;

end process;

end Behavioral;
