----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2018 14:38:17
-- Design Name: 
-- Module Name: ctrlFSM - Behavioral
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

entity ctrlFSM is
  Port ( 
        curr_state      :       in integer;
        --ins_dec         :       in std_logic_vector(10 downto 0);
        clk             :       in std_logic;

        class	       :       in std_logic_vector(1 downto 0);
 --       dp_ctg  :       in std_logic_vector(1 downto 0);
 --       dt_ctg  :       in std_logic_vector(2 downto 0);
 --       variant :       in std_logic_vector(1 downto 0);
 --       unimplemented   :   in std_logic;
 --       undefined       :   in std_logic;
          mla             :   in std_logic;
          shift 			:	in std_logic;
          shift_reg			:	in std_logic;
          L 				:	in std_logic;

        next_state      :       out integer
   );
end ctrlFSM;

architecture Behavioral of ctrlFSM is

begin

process(clk)
begin

	if (clk'event and clk='1') then

		if (curr_state = 1) then
			if(class = "11") then
				next_state <= 10;
			elsif (class = "00" and shift_reg = '0') then
				next_state <= 2;
			elsif (class = "00" and shift_reg = '1') then
				next_state <= 3;
			elsif (class = "10" and L = '0') then
				next_state <= 20;
			elsif (class = "10" and L = '1') then
				next_state <= 21;
			end if;

		elsif (curr_state = 2) then
			if ( shift = '1' ) then 
				next_state <= 6;
			elsif ( shift = '0' and class = "01") then
				next_state <= 16;
			elsif ( shift = '0' and class = "00") then
				next_state <= 7;
			end if;

		elsif (curr_state = 3) then
			next_state <= 4;
		elsif (curr_state = 4) then
			next_state <= 5;
		elsif (curr_state = 5) then
			next_state <= 8;
		elsif (curr_state = 6) then
			if (class = "01") then
				next_state <= 15;
			elsif (class = "00") then
				next_state <= 8;
			end	if;

		elsif (curr_state = 7) then
			next_state <= 9;
		elsif (curr_state = 8) then
			next_state <= 9;
		elsif (curr_state = 9) then
			next_state <= 1;
		elsif (curr_state = 10) then
			next_state <= 11;
		elsif (curr_state = 11) then
			if(class = "11" and mla = '1') then
				next_state <= 13;
			elsif (class = "11" and mla = '0') then
				next_state <= 12;
			end if;

		elsif (curr_state = 12) then
			next_state <= 1;
		elsif (curr_state = 13) then
			next_state <= 14;
		elsif (curr_state = 14) then
			next_state <= 1;
		elsif (curr_state = 15) then
			if( ins_dec(6 downto 4) = "001" or ins_dec(6 downto 4) = "110" or ins_dec(6 downto 4) = "111" ) then
				next_state <= 17;
			else
				next_state <= 18;
			end	if;

		elsif (curr_state = 16) then
			if( ins_dec(6 downto 4) = "001" or ins_dec(6 downto 4) = "110" or ins_dec(6 downto 4) = "111" ) then
				next_state <= 17;
			else
				next_state <= 18;
			end	if;

		elsif (curr_state = 17) then
			next_state <= 1;
		elsif (curr_state = 18) then
			next_state <= 19;
		elsif (curr_state = 19) then
			next_state <= 1;
		elsif (curr_state = 20) then
			next_state <= 1;
		elsif (curr_state = 21) then
			next_state <= 20;
		else
			next_state <= 1;
		end if;

	end if;

end process;

end Behavioral;
