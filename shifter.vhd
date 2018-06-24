----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2018 19:18:10
-- Design Name: 
-- Module Name: shifter - Behavioral
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
--use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
--Use Ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shifter is
    Port ( input : in STD_LOGIC_VECTOR (31 downto 0);
           amount : in STD_LOGIC_VECTOR (4 downto 0);
           opcode : in STD_LOGIC_VECTOR (1 downto 0);
           carry :  out std_logic;     
           output : out STD_LOGIC_VECTOR (31 downto 0));
end shifter;

architecture Behavioral of shifter is

begin

output <=   std_logic_vector(shift_left(unsigned(input),to_integer(unsigned(amount)) )) when opcode="00" else 
            std_logic_vector(shift_right(unsigned(input),to_integer(unsigned(amount)) )) when opcode="01" else
            std_logic_vector(shift_right(signed(input),to_integer(unsigned(amount)) )) when opcode="10" else
            std_logic_vector(rotate_right(signed(input),to_integer(unsigned(amount)) )) when opcode="11" ;
--            input ror to_integer(unsigned(amount)) ;

carry <= input(32 - to_integer(unsigned(amount)) ) when opcode="00" else
        input(to_integer(unsigned(amount)) ) when opcode="01" else
        input(to_integer(unsigned(amount)) ) when opcode="10" else
        input(to_integer(unsigned(amount)) ) when opcode="11";
end Behavioral;
