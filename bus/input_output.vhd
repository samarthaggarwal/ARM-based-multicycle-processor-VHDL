----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2018 01:08:58
-- Design Name: 
-- Module Name: input_output - Behavioral
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

entity input_output is
    Port ( clk : in STD_LOGIC;
           pushbutton : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (15 downto 0);
           out_led : out STD_LOGIC_VECTOR (15 downto 0);
           cathode : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end input_output;

architecture Behavioral of input_output is

signal out_ssd : STD_LOGIC_VECTOR (15 downto 0);
signal in_processor : STD_LOGIC_VECTOR (31 downto 0);

begin

    myBus : entity work.myBus
        Port Map (
            clk => clk,
            input => input,
            out_led => out_led,
            out_ssd => out_ssd
        );
        
--    processor : entity work=processor
--        Port Map (
--            clk => clk,
--            ins => in_processor
--        );

    disp : entity work.display
        Port map (  b => out_ssd,
                clk => clk,
                pushbutton => pushbutton,
                cathode => cathode,
                anode => anode);

end Behavioral;
