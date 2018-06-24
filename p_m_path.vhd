----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2018 13:31:23
-- Design Name: 
-- Module Name: p_m_path - Behavioral
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
--use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity p_m_path is
    Port ( in_p : in STD_LOGIC_VECTOR (31 downto 0);
           in_m : in STD_LOGIC_VECTOR (31 downto 0);
--           opcode : in STD_LOGIC_VECTOR (5 downto 0); -- I P U B W L
           opcode : in STD_LOGIC_VECTOR (2 downto 0);
           -- 2 downto 0 -> 
           --               ldr -> 000
           --               str -> 001
           --               ldrb -> 010 
           --               ldrh -> 011
           --               ldrsb -> 100 
           --               ldrsh -> 101 
           --               strb -> 110
           --               strh -> 111
           -- 3 -> signed = 1 ; unsigned = 2
           offset : in STD_LOGIC_VECTOR (1 downto 0);
           out_p : out STD_LOGIC_VECTOR (31 downto 0);
           out_m : out STD_LOGIC_VECTOR (31 downto 0);
           write_en : out STD_LOGIC_VECTOR (1 downto 0));
end p_m_path;

architecture Behavioral of p_m_path is

signal off : natural;

begin

    off <= to_integer(unsigned(offset))*8;
    
    out_p <=    in_m when (opcode(2 downto 0) = "000") else
                std_logic_vector(to_unsigned(to_integer(unsigned(in_m(31-off downto 24-off)) ), 32)) when (opcode(2 downto 0) = "010") else
                std_logic_vector(to_unsigned(to_integer(unsigned(in_m(31-off downto 16-off)) ), 32)) when (opcode(2 downto 0) = "011") else 
                std_logic_vector(to_signed(to_integer(signed(in_m(31-off downto 24-off)) ), 32)) when (opcode(2 downto 0) = "100") else 
                std_logic_vector(to_signed(to_integer(signed(in_m(31-off downto 16-off)) ), 32)) when (opcode(2 downto 0) = "101") ;
    
    out_m <=    in_p when (opcode(2 downto 0) = "001") else
                std_logic_vector( shift_right(unsigned(in_p(7 downto 0)), off) ) when (opcode(2 downto 0) = "110") else
                std_logic_vector( shift_right(unsigned(in_m(15 downto 0)), off) ) when (opcode(2 downto 0) = "111") ;
                
    write_en <= offset when ( (opcode = "001") OR (opcode = "110") OR (opcode = "111")) else "00";


end Behavioral;
