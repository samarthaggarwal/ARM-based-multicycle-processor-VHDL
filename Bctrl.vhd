----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2018 14:06:50
-- Design Name: 
-- Module Name: Bctrl - Behavioral
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

entity Bctrl is
    Port ( ins : in STD_LOGIC_VECTOR (31 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0); --CVZN
           p : out STD_LOGIC);
end Bctrl;

architecture Behavioral of Bctrl is

signal c : STD_LOGIC :='0';
signal v : STD_LOGIC :='0';
signal z : STD_LOGIC :='0';
signal n : STD_LOGIC :='0';

begin

c <= flags(3);
v <= flags(1);
z <= flags(1);
n <= flags(0);

p <=    '1' when ( (ins(31 downto 28) = "0000") and (z='1') ) else
        '1' when ( (ins(31 downto 28) = "0001") and (z='0') ) else
        '1' when ( (ins(31 downto 28) = "0010") and (c='1') ) else
        '1' when ( (ins(31 downto 28) = "0011") and (c='0') ) else
        '1' when ( (ins(31 downto 28) = "0100") and (n='1') ) else
        '1' when ( (ins(31 downto 28) = "0101") and (n='0') ) else
        '1' when ( (ins(31 downto 28) = "0110") and (v='1') ) else
        '1' when ( (ins(31 downto 28) = "0111") and (v='0') ) else
        '1' when ( (ins(31 downto 28) = "1000") and (c='1') and (z='0') ) else
        '1' when ( (ins(31 downto 28) = "1001") and (c='0') and (z='1') ) else
        '1' when ( (ins(31 downto 28) = "1010") and (n=v) ) else
        '1' when ( (ins(31 downto 28) = "1011") and (n/=v) ) else
        '1' when ( (ins(31 downto 28) = "1100") and (z='0') and (n=v) ) else
        '1' when ( (ins(31 downto 28) = "1101") and (z='1') and (n/=v) ) else
        '1' when ( (ins(31 downto 28) = "1110") ) else
        '1' when ( (ins(31 downto 28) = "1111") ) else '0';

end Behavioral;
