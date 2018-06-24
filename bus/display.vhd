----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2018 17:30:28
-- Design Name: 
-- Module Name: display - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    Port (  b : in STD_LOGIC_VECTOR (15 downto 0) :=(others => '0');
            clk : in STD_LOGIC :='0';
            pushbutton : in STD_LOGIC :='0';
            cathode : out STD_LOGIC_VECTOR (6 downto 0) :=(others => '0');
            anode : out STD_LOGIC_VECTOR (3 downto 0) :=(others => '0'));
end display;

architecture Behavioral of display is
    signal count : INTEGER :=0;
    signal count2 : INTEGER :=5;
    signal cat0 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat1 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat2 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat3 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal an : STD_LOGIC_VECTOR (3 downto 0) :=(others => '1');
    signal pb : STD_LOGIC;

begin

pb <= pushbutton;
process(clk)
begin
    if (clk'event and clk='1') then
        case b(15 downto 12) is
            when "0000" => cat0(6 downto 0) <= "1000000";
            when "0001" => cat0(6 downto 0) <= "1111001";
            when "0010" => cat0(6 downto 0) <= "0100100";
            when "0011" => cat0(6 downto 0) <= "0110000";
            when "0100" => cat0(6 downto 0) <= "0011001";
            when "0101" => cat0(6 downto 0) <= "0010010";
            when "0110" => cat0(6 downto 0) <= "0000010";
            when "0111" => cat0(6 downto 0) <= "1111000";
            when "1000" => cat0(6 downto 0) <= "0000000";
            when "1001" => cat0(6 downto 0) <= "0010000";
            when "1100" => cat0(6 downto 0) <= "1000111";
            when "1101" => cat0(6 downto 0) <= "0001001";
            when others => cat0(6 downto 0) <= "1000000";
        end case;
        
        case b(11 downto 8) is
            when "0000" => cat1(6 downto 0) <= "1000000";
            when "0001" => cat1(6 downto 0) <= "1111001";
            when "0010" => cat1(6 downto 0) <= "0100100";
            when "0011" => cat1(6 downto 0) <= "0110000";
            when "0100" => cat1(6 downto 0) <= "0011001";
            when "0101" => cat1(6 downto 0) <= "0010010";
            when "0110" => cat1(6 downto 0) <= "0000010";
            when "0111" => cat1(6 downto 0) <= "1111000";
            when "1000" => cat1(6 downto 0) <= "0000000";
            when "1001" => cat1(6 downto 0) <= "0010000";
            when "1100" => cat1(6 downto 0) <= "1000111";
            when "1101" => cat1(6 downto 0) <= "0001001";
            when others => cat1(6 downto 0) <= "1000000";
        end case;
                
        case b(7 downto 4) is
            when "0000" => cat2(6 downto 0) <= "1000000";
            when "0001" => cat2(6 downto 0) <= "1111001";
            when "0010" => cat2(6 downto 0) <= "0100100";
            when "0011" => cat2(6 downto 0) <= "0110000";
            when "0100" => cat2(6 downto 0) <= "0011001";
            when "0101" => cat2(6 downto 0) <= "0010010";
            when "0110" => cat2(6 downto 0) <= "0000010";
            when "0111" => cat2(6 downto 0) <= "1111000";
            when "1000" => cat2(6 downto 0) <= "0000000";
            when "1001" => cat2(6 downto 0) <= "0010000";
            when "1100" => cat2(6 downto 0) <= "1000111";
            when "1101" => cat2(6 downto 0) <= "0001001";
            when others => cat2(6 downto 0) <= "0111111";
        end case;
                        
        case b(3 downto 0) is
            when "0000" => cat3(6 downto 0) <= "1000000";
            when "0001" => cat3(6 downto 0) <= "1111001";
            when "0010" => cat3(6 downto 0) <= "0100100";
            when "0011" => cat3(6 downto 0) <= "0110000";
            when "0100" => cat3(6 downto 0) <= "0011001";
            when "0101" => cat3(6 downto 0) <= "0010010";
            when "0110" => cat3(6 downto 0) <= "0000010";
            when "0111" => cat3(6 downto 0) <= "1111000";
            when "1000" => cat3(6 downto 0) <= "0000000";
            when "1001" => cat3(6 downto 0) <= "0010000";
            when "1100" => cat3(6 downto 0) <= "1000111";
            when "1101" => cat3(6 downto 0) <= "0001001";
            when others => cat3(6 downto 0) <= "0111111";
        end case;
        
        if( ( ((count mod (10**5)) = 0) and pb='0' ) or pb='1' ) then
            count2 <= (count2+1) mod 4;
            count <= 0;
        end if;
        
        count <= count+1;
        
        
            if(count2=1) then
                anode(3 downto 0) <= "1011";
                cathode(6 downto 0) <= cat1(6 downto 0);
            elsif(count2=2) then
                anode(3 downto 0) <= "1101";
                cathode(6 downto 0) <= cat2(6 downto 0);
            elsif(count2=3) then
                anode(3 downto 0) <= "1110";
                cathode(6 downto 0) <= cat3(6 downto 0);
            elsif(count2=0) then
                anode(3 downto 0) <= "0111";
                cathode(6 downto 0) <= cat0(6 downto 0);
            else
                anode(3 downto 0) <= "0111";
                cathode(6 downto 0) <= cat0(6 downto 0);
            end if;
                
        
    end if;
    
--    cathode(6 downto 0) <= cat(6 downto 0);
--    anode(3 downto 0) <= an(3 downto 0);
    

end process;

end Behavioral;
