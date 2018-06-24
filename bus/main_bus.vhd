----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2018 22:38:07
-- Design Name: 
-- Module Name: main_bus - Behavioral
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

entity main_bus is
    Port ( clk : in STD_LOGIC;
           switch : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           cathode : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end main_bus;

architecture Behavioral of main_bus is

signal hwdata : std_logic_vector (31 downto 0);
signal haddr : std_logic_vector (31 downto 0);

signal hsel : std_logic_vector(1 downto 0);
signal hsel_1 : std_logic;
signal hsel_2 : std_logic;
signal hsel_3 : std_logic; 

signal hrdata : std_logic_vector (31 downto 0);
signal hrdata_1 : std_logic_vector (31 downto 0);
signal hrdata_2 : std_logic_vector (31 downto 0);
signal hrdata_3 : std_logic_vector (31 downto 0);

signal hwrite : std_logic;
signal hsize : std_logic_vector(2 downto 0);
signal htrans : std_logic_vector(1 downto 0);

begin

processor : entity work.master_interface
        port map (
            hclk => clk,
            hwdata => hwdata,
            haddr => haddr,
            hrdata => hrdata,
            hwrite => hwrite,
            hsize => hsize,
            htrans => htrans
        );
        
memory_1 : entity work.slave_interface_memory
        port map(
            hclk => clk,
            hsel => hsel_1,
            haddr => haddr,
            hwdata => hwdata,
            hrdata => hrdata_1,
            hwrite => hwrite,
            hsize => hsize,
            htrans => htrans
        );
        
switch_1 : entity work.slave_interface_switch
        port map(
            hclk => clk,
            hsel => hsel_2,
            haddr => haddr,
            hwdata => hwdata,
            hrdata => hrdata_2,
            hwrite => hwrite,
            hsize => hsize,
            htrans => htrans,
            switch => switch
        );
        
led_1 : entity work.slave_interface_led
            port map(
                hclk => clk,
                hsel => hsel_3,
                haddr => haddr,
                hwdata => hwdata,
                hrdata => hrdata_3,
                hwrite => hwrite,
                hsize => hsize,
                htrans => htrans,
                led => led
            );

end Behavioral;
