----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2018 12:51:42
-- Design Name: 
-- Module Name: alu - Behavioral
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
-- use IEEE.NUMERIC_STD.ALL;
Use Ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( operand1 : in STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in STD_LOGIC_VECTOR (31 downto 0);
           carry : in STD_LOGIC;
           optype : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           flags : out STD_LOGIC_VECTOR (3 downto 0)); -- ZNVC
end alu;

architecture Behavioral of alu is
    -- optype 5 downto 0 : 4-0 bits basic alu and 5th bit ldr, str etc.
--    signal x : string;
    signal res : STD_LOGIC_VECTOR (31 downto 0);
    signal c31 : std_logic;
    signal c32 : std_logic;
begin

--    x <=    "and" when optype = "0000" else
--            "eor" when optype = "0001" else
--            "sub" when optype = "0010" else
--            "rsb" when optype = "0011" else
--            "add" when optype = "0100" else
--            "adc" when optype = "0101" else
--            "sbc" when optype = "0110" else
--            "rsc" when optype = "0111" else
--            "tst" when optype = "1000" else
--            "teq" when optype = "1001" else
--            "cmp" when optype = "1010" else
--            "cmn" when optype = "1011" else
--            "orr" when optype = "1100" else
--            "mov" when optype = "1101" else
--            "bic" when optype = "1110" else
--            "mvn" when optype = "1111";
            
--    x <=    "and" when optype = "00000" else
--            "eor" when optype = "00001" else
--            "sub" when optype = "00010" else
--            "rsb" when optype = "00011" else
--            "add" when optype = "00100" else
--            "adc" when optype = "00101" else
--            "sbc" when optype = "00110" else
--            "rsc" when optype = "00111" else
--            "tst" when optype = "01000" else
--            "teq" when optype = "01001" else
--            "cmp" when optype = "01010" else
--            "cmn" when optype = "01011" else
--            "orr" when optype = "01100" else
--            "mov" when optype = "01101" else
--            "bic" when optype = "01110" else
--            "mvn" when optype = "01111" else
    
--            "ldru" when optype = "10001" else
--            "ldr" when optype = "10000" else
    
--            "stru" when optype = "10011" else
--            "str" when optype = "10010" else
    
--            "b" when optype = "10100" else
--            "bl" when optype = "10101" else
    
--            "mul" when optype = "11000" else
--            "mla" when optype = "11001";
            
    res <=  operand1 AND operand2 when optype = "0000" else
            operand1 XOR operand2 when optype = "0001" else
            operand1 + (NOT operand2) + 1 when optype = "0010" else
            (NOT operand1) + operand2 + 1 when optype = "0011" else
            operand1 + operand2 when optype = "0100" else
            operand1 + operand2 + carry when optype = "0101" else
            operand1 + (NOT operand2) + carry when optype = "0110" else
            (NOT operand1) + operand2 + carry when optype = "0111" else
            operand1 AND operand2 when optype = "1000" else
            operand1 XOR operand2 when optype = "1001" else
            operand1 + (NOT operand2) + carry when optype = "1010" else
            operand1 + operand2 when optype = "1011" else
            operand1 OR operand2 when optype = "1100" else
            operand1 AND (NOT operand2) when optype = "1101" else
            (NOT operand2) when optype = "1110" else
            operand1 AND operand2 when optype = "1111";
            
--    res <=  operand1 AND operand2 when optype = "00000" else
--            operand1 XOR operand2 when optype = "00001" else
--            operand1 + (NOT operand2) + 1 when optype = "00010" else
--            (NOT operand1) + operand2 + 1 when optype = "00011" else
--            operand1 + operand2 when optype = "00100" else
--            operand1 + operand2 + carry when optype = "00101" else
--            operand1 + (NOT operand2) + carry when optype = "00110" else
--            (NOT operand1) + operand2 + carry when optype = "00111" else
--            operand1 AND operand2 when optype = "01000" else
--            operand1 XOR operand2 when optype = "01001" else
--            operand1 + (NOT operand2) + carry when optype = "01010" else
--            operand1 + operand2 when optype = "01011" else
--            operand1 OR operand2 when optype = "01100" else
--            operand1 AND (NOT operand2) when optype = "01101" else
--            (NOT operand2) when optype = "01110" else
--            operand1 AND operand2 when optype = "01111" else
    
--            operand1 + operand2 when optype = "10001" else
--            operand1 + (NOT operand2) +1 when optype = "10000" else
    
--            operand1 + operand2 when optype = "10011" else
--            operand1 + (NOT operand2) +1 when optype = "10010" else
    
--            operand1 + operand2 when optype = "10100" else
--            operand1 + operand2 when optype = "10101" else
    
--            operand1 * operand2 when optype = "11000" else
--            operand1 + (operand1 * operand2) when optype = "11001";
            
            -- Flags Z N V C
            
            result <= res;
            c31 <= operand1(31) XOR operand2(31) XOR res(31);
            c32 <= ( operand1(31) AND operand2(31) ) OR ( operand1(31) AND res(31) ) OR ( operand2(31) AND res(31) );
            flags(3) <= '1' when res="0" else '0';
            flags(2) <= '1' when res(31)='1' else '0';
            flags(1) <= c31 XOR c32; 
            flags(0) <= c32;
--            flags(1) <= 

end Behavioral;
