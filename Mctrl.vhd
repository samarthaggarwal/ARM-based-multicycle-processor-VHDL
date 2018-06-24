----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2018 14:32:08
-- Design Name: 
-- Module Name: Mctrl - Behavioral
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

entity Mctrl is
    Port ( ins : in STD_LOGIC_VECTOR (31 downto 0);
           p : in STD_LOGIC;
           Rsrc : out STD_LOGIC;
           Psrc : out STD_LOGIC;
           M2R : out STD_LOGIC;
           MR : out STD_LOGIC;
           MW : out STD_LOGIC;
           Fset : out STD_LOGIC;
           Asrc : out STD_LOGIC;
           RW : out STD_LOGIC);
end Mctrl;

architecture Behavioral of Mctrl is

signal xxx : STD_LOGIC;

begin

Rsrc <= xxx;
Asrc <= xxx;
M2R <= xxx;

xxx <=  '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='1') and (ins(23)='0') ) else
        '1' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='0') ) else
        '1' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='1') );
        
RW <=    p when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='0') ) else
         p when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='1') ) else
         p when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='0') ) else
         p when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='1') and (ins(23)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='0') ) else
         p when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='1') and (ins(26)='0') );
        
MW <=   '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='1') and (ins(23)='0') ) else
         p when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='1') and (ins(26)='0') );
                        
MR <=   '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='1') and (ins(23)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='0') ) else
        '1' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='1') and (ins(26)='0') );
                                
Psrc <= '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='1') and (ins(23)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='1') ) else
         p when ( (ins(27)='1') and (ins(26)='0') );
        
Fset <= '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='0') ) else
         p when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='0') and (ins(20)='1') ) else
        '0' when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='0') ) else
         p when ( (ins(27)='0') and (ins(26)='0') and (ins(23)='1') and (ins(20)='1') ) else
         p when ( (ins(27)='0') and (ins(26)='0') and (ins(24)='1') and (ins(23)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='0') ) else
        '0' when ( (ins(27)='0') and (ins(26)='1') and (ins(20)='1') ) else
        '0' when ( (ins(27)='1') and (ins(26)='0') );
    

end Behavioral;
