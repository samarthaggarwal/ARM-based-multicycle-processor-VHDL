----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2018 14:07:55
-- Design Name: 
-- Module Name: Ins_Decoder - Behavioral
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

entity Ins_Decoder is
    Port ( ins : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (10 downto 0));
end Ins_Decoder;

architecture Behavioral of Ins_Decoder is

signal class : std_logic_vector(1 downto 0);
signal sub_class1 : std_logic_vector(1 downto 0);
signal sub_class2 : std_logic_vector(2 downto 0);
signal varient : std_logic_vector(1 downto 0);
signal unimplemented : std_logic;
signal undefined : std_logic;


begin

     -- 10 : Branch; 01 : DT; 00 : DP ; 11 : MUL
    class(1 downto 0) <=    "01" when ins(27 downto 26)="01" else
                            "10" when ins(27 downto 26)="10" else
                            "11" when ( (ins(27 downto 26)="00") and (ins(7)='1') and (ins(4)='1') and (ins(6 downto 5)="00") ) else
                            "01" when ( (ins(27 downto 26)="00") and (ins(7)='1') and (ins(4)='1') ) else
                            "00" when ins(27 downto 26)="00";
                       
    -- 00 : arith; 01 : logic; 10 : test;                            
    sub_class1 <=   "10" when ins(25 downto 24)="10" else
                    "00" when ( (ins(25 downto 24)="01") or (ins(25 downto 23)="001") ) else 
                    "01";
                    
    --               ldr -> 000
    --               str -> 001
    --               ldrb -> 010 
    --               ldrh -> 011
    --               ldrsb -> 100 
    --               ldrsh -> 101 
    --               strb -> 110
    --               strh -> 111
    
    sub_class2 <=   "000" when ( (ins(27 downto 26)="01") and (ins(20)='1') and(ins(22)='0') ) else
                    "001" when ( (ins(27 downto 26)="01") and (ins(20)='0') and(ins(22)='0') ) else
                    "100" when ( (ins(27 downto 26)="01") and (ins(20)='1') and(ins(22)='1') and (ins(6 downto 5)="10") ) else
                    "010" when ( (ins(27 downto 26)="01") and (ins(20)='1') and(ins(22)='1') ) else
                    "110" when ( (ins(27 downto 26)="01") and (ins(20)='0') and(ins(22)='1') ) else
                    "101" when ( (ins(27 downto 26)="00") and (ins(20)='1') and (ins(7)='1') and (ins(4)='1') and (ins(6 downto 5)/="00") and(ins(22)='0') and (ins(6 downto 5)="10")) else
                    "011" when ( (ins(27 downto 26)="00") and (ins(20)='1') and (ins(7)='1') and (ins(4)='1') and (ins(6 downto 5)/="00") and(ins(22)='0')) else
                    "111" when ( (ins(27 downto 26)="00") and (ins(20)='0') and (ins(7)='1') and (ins(4)='1') and (ins(6 downto 5)/="00") and(ins(22)='0'));
               
    -- 00 : imm; 01 : reg_imm; 10 : reg_reg;                    
    varient <=  "00" when ( (ins(27 downto 26)="10") and (ins(25)='1') ) else
                "00" when ( (ins(27 downto 26)="00") and (ins(25)='1') ) else
                "01" when ( (ins(27 downto 26)="00") and (ins(25)='0') and (ins(4)='0') ) else
                "10" when ( (ins(27 downto 26)="00") and (ins(25)='0') and (ins(4)='1') and (ins(7)='0') ) else
                "10" when ( (ins(27 downto 26)="00") and (ins(25)='0') and (ins(4)='1') and (ins(7)='1') and (ins(6 downto 5)="00") ) else
                "00" when ( (ins(27 downto 26)="01") and (ins(25)='0') ) else
                "01" when ( (ins(27 downto 26)="01") and (ins(25)='1') ); -- halfword doubt
                
    unimplemented <=    '1' when ( (ins(27 downto 25)="000") and (ins(11 downto 8)="1111") and (ins(7)='0') and (ins(4)='1') ) else
                        '1' when ( (ins(27 downto 25)="000") and (ins(24 downto 23)="01") and (ins(7 downto 4)="1001") ) else
                        '1' when ( (ins(27 downto 25)="000") and (ins(24)='1') and (ins(7 downto 4)="1001") ) else
                        '1' when ( (ins(27 downto 25)="100") ) else
                        '1' when ( ins(27 downto 26)="11" ) else
                        '0';
    
    undefined <=    '1' when ( (ins(27 downto 25)="011") and (ins(4)='1') ) else
                    '0';

end Behavioral;
