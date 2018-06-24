----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2018 14:25:08
-- Design Name: 
-- Module Name: ctrlSigGen - Behavioral
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

entity ctrlSigGen is
  Port ( 
        state       :       in integer;     -- from ctrlFSM
        I24         :       in std_logic;   --L in decoder
        I21			:		in std_logic;  --mla in decoder
        shift_op	:		in std_logic_vector(1 downto 0); -- IR(6 downto 5), shift_op in decoder
        p 			:		in std_logic;	--from Bctrl
        pm_op       :       in std_logic_vector(2 downto 0);    -- dt_ctg in decoder
        pm_offset   :       in std_logic_vector(1 downto 0);

        
        PW          :       out std_logic;
        IorD        :       out std_logic_vector(1 downto 0);
        MemW        :       out std_logic;
        PM_opc      :       out std_logic_vector(2 downto 0);
        PM_off      :       out std_logic_vector(1 downto 0);
        IW          :       out std_logic;
        DW          :       out std_logic;
        Rsrc1       :       out std_logic;
        Rsrc2       :       out std_logic;
        Rwad        :       out std_logic_vector(1 downto 0);
        M2R         :       out std_logic_vector(1 downto 0);
        RW          :       out std_logic;
        AW          :       out std_logic;
        BW          :       out std_logic;
        SH_amt      :       out std_logic;
        SH_opc      :       out std_logic_vector(1 downto 0);
        S_ctrl      :       out std_logic;
        M_ctrl      :       out std_logic;
        Asrc1       :       out std_logic_vector(1 downto 0);
        Asrc2       :       out std_logic_vector(2 downto 0);
--        op          :       out std_logic_vector(3 downto 0);     -- op for alu is handles by Actrl
        REW         :       out std_logic;
        F_set       :       out std_logic;
        C_set       :       out std_logic;
        C_ch        :       out std_logic
   );
end ctrlSigGen;

architecture Behavioral of ctrlSigGen is

begin

    PW <= '1' when (state = 1 or state = 20) else '0';

    IorD <= "01" when (I24 = '1' and (state = 17 or state = 18) ) else
            "10" when (I24 = '0' and (state = 17 or state = 18) ) else
            "00";

    MemW <= '1' when state = 17 else '0';

     PM_opc <= pm_op;

     PM_off <= pm_offset;    --last 2 bits of address

    IW <= '1' when state = 1 else '0';

    DW <= '1' when state = 18 else '0';

    Rsrc1 <= '1' when (state = 3 or state = 10) else '0';

    Rsrc2 <= '1' when (state = 10 or state = 15 or state = 16) else '0';

    Rwad <= "01" when (state = 12 or state = 14 or state = 17 or state = 18 ) else 
    		"10" when state = 21 else
    		"00";

    M2R <= "01" when state = 19 else
    		"10" when state = 12 else
    		"11" when state = 21 else
    		"00";

    RW <= '1' when ( state = 9 or state = 12 or state = 14 or state = 19 or state = 21 or (I21 = '1' and (state = 17 or state = 18) ) ) else '0';

    AW <= '1' when (state = 2 or state = 3 or state = 5 or state = 10 ) else '0';

    BW <= '1' when (state = 2 or state = 3 or state = 10 or state = 13 or state = 15 or state = 16 ) else '0';

    SH_amt <= '1' when state = 6 else '0';

    SH_opc <= shift_op ;

    S_ctrl <= '1' when (state = 4 or state = 6) else '0';

    M_ctrl <= '1' when (state = 11) else '0';

    Asrc1 <= "01" when (state = 7 or state = 8 or state = 15 or state = 16) else
    			"10" when (state = 13) else
    			"00";

    Asrc2 <= "001" when state = 1 else
    		"010" when state = 16 else
    		"011" when state = 20 else
    		"100" when (state = 8 or state = 15) else
    		"000";

--    op <= IR(24 downto 21) when (state = 7 or state = 8) else "0100";	-- 0100 is opcode for plus

    REW <= '1' when	(state = 7 or state = 8 or state = 13 or state = 15 or state = 16) else '0';

    F_set <= p when (state = 7 or state = 8 or state = 13) else '0';

    C_set <= '1' when (state = 4 or state = 6 or state = 11 or state = 7) else '0';

    C_ch <= '1' when (state = 11) else '0';

end Behavioral;