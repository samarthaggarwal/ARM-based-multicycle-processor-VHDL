----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2018 14:05:33
-- Design Name: 
-- Module Name: Actrl - Behavioral
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
Use Ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Actrl is
    Port ( ins : in STD_LOGIC_VECTOR (31 downto 0);
           opcode_alu : out STD_LOGIC_VECTOR (3 downto 0);
           opcode_shift : out STD_LOGIC_VECTOR (2 downto 0));
end Actrl;

architecture Behavioral of Actrl is

begin

    opcode_alu <= ins(24 downto 21);
    opcode_shift <= ins(6 downto 5);

end Behavioral;
