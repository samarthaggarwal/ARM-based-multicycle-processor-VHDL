----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2018 14:55:20
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
    Port ( ins : in STD_LOGIC_VECTOR (31 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0);
           opcode_alu : out STD_LOGIC_VECTOR (3 downto 0);
           opcode_shift : out STD_LOGIC_VECTOR (2 downto 0);
           Rsrc : out STD_LOGIC;
           Psrc : out STD_LOGIC;
           M2R : out STD_LOGIC;
           MR : out STD_LOGIC;
           MW : out STD_LOGIC;
           Fset : out STD_LOGIC;
           Asrc : out STD_LOGIC;
           RW : out STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

signal p : STD_LOGIC;

begin


    actrl : entity work.Actrl port map(
        ins => ins,
        opcode_alu => opcode_alu,
        opcode_shift => opcode_shift
    );
    
    bctrl : entity work.Bctrl port map(
        ins => ins,
        flags => flags,
        p => p
    );
    
    mctrl : entity work.Mctrl port map(
        ins => ins,
        p => p,
        Rsrc => Rsrc,
        Psrc => psrc,
        M2R => M2R,
        MR => MR,
        MW => MW,
        Fset => Fset,
        Asrc => Asrc,
        RW => RW
    );
    
    

end Behavioral;
