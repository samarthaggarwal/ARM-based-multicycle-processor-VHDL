----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 23:31:27
-- Design Name: 
-- Module Name: processor - Behavioral
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

entity processor is
  Port (
    clock     :       in std_logic
   );
end processor;

architecture Behavioral of processor is

        signal instr       :        std_logic_vector(31 downto 0);
--        signal clk         :        std_logic;
        signal flags   :        std_logic_vector(3 downto 0);
        
        signal OP          :        std_logic_vector(3 downto 0);    -- alu opcode
        
        signal PW          :        std_logic;
        signal IorD        :        std_logic_vector(1 downto 0);
        signal MemW        :        std_logic;
        signal PM_opc      :        std_logic_vector(2 downto 0);
        signal PM_off      :        std_logic_vector(1 downto 0);
        signal IW          :        std_logic;
        signal DW          :        std_logic;
        signal Rsrc1       :        std_logic;
        signal Rsrc2       :        std_logic;
        signal Rwad        :        std_logic_vector(1 downto 0);
        signal M2R         :        std_logic_vector(1 downto 0);
        signal RW          :        std_logic;
        signal AW          :        std_logic;
        signal BW          :        std_logic;
        signal SH_amt      :        std_logic_vector(1 downto 0);
        signal SH_in       :        std_logic;
        signal SH_opc      :        std_logic_vector(1 downto 0);
        signal S_ctrl      :        std_logic;
        signal M_ctrl      :        std_logic;
        signal Asrc1       :        std_logic_vector(1 downto 0);
        signal Asrc2       :        std_logic_vector(2 downto 0);
        signal REW         :        std_logic;
        signal F_set       :        std_logic;
        signal C_set       :        std_logic;
        signal C_ch        :        std_logic;

--component controller
--    port(
--        instr       :       in std_logic_vector(31 downto 0);
--        clk         :       in std_logic;
--        flags   :       in std_logic_vector(3 downto 0);
        
--        OP          :       out std_logic_vector(3 downto 0);    -- alu opcode
        
--        PW          :       out std_logic;
--        IorD        :       out std_logic_vector(1 downto 0);
--        MemW        :       out std_logic;
--        PM_opc      :       out std_logic_vector(2 downto 0);
--        PM_off      :       out std_logic_vector(1 downto 0);
--        IW          :       out std_logic;
--        DW          :       out std_logic;
--        Rsrc1       :       out std_logic;
--        Rsrc2       :       out std_logic;
--        Rwad        :       out std_logic_vector(1 downto 0);
--        M2R         :       out std_logic_vector(1 downto 0);
--        RW          :       out std_logic;
--        AW          :       out std_logic;
--        BW          :       out std_logic;
--        SH_amt      :       out std_logic;
--        SH_opc      :       out std_logic_vector(1 downto 0);
--        S_ctrl      :       out std_logic;
--        M_ctrl      :       out std_logic;
--        Asrc1       :       out std_logic_vector(1 downto 0);
--        Asrc2       :       out std_logic_vector(2 downto 0);
--    --        op          :       out std_logic_vector(3 downto 0);     -- op for alu is handles by Actrl
--        REW         :       out std_logic;
--        F_set       :       out std_logic;
--        C_set       :       out std_logic;
--        C_ch        :       out std_logic
--   );
--end component;

--component data_path
--    Port (  PW : in std_logic;
--            IorD : in std_logic_vector(1 downto 0); 
----            MR : in std_logic;
--            MemW : in std_logic;
--            IW : in std_logic;
--            DW : in std_logic;
--            Rsrc2 : in std_logic :='0';
--            Rsrc1 : in std_logic :='0';
--            Rwad    :   in std_logic_vector(1 downto 0);
--            M2R : in std_logic_vector(1 downto 0);
--            BW : in std_logic;
--            RW : in std_logic;
--            AW : in std_logic ;                 
--            Asrc1 : in std_logic_vector(1 downto 0);
--            Asrc2 : in std_logic_vector(2 downto 0);
--            F_set : in std_logic;
--            C_set : in std_logic;   
--            C_ch    : in std_logic;
--            ReW : in std_logic;
--            op : in std_logic_vector(3 downto 0); 
--            SH_OPC : in std_logic_vector(1 downto 0);
--            SH_amt  : in std_logic;
--            S_CTRL : in std_logic;
--            M_CTRL : in std_logic;
--            PM_OPC : in std_logic_vector(2 downto 0);
--            PM_OFF : in std_logic_vector(1 downto 0);
--            instr : in std_logic_vector(31 downto 0);
--            flags :  out std_logic_vector(3 downto 0);
--            clk : in std_logic );
            
--end component;

    

begin

     data : entity work.data_path
        port map(
                         instr      => instr,  
                        clk         => clock,
                        flags   => flags,
                        
                        OP          => OP,
                        
                        PW          => PW,
                        IorD        => IorD,
                        MemW        => MemW,
                        PM_opc      => PM_opc,
                        PM_off      => PM_off,
                        IW          => IW    ,
                        DW          => DW    ,
                        Rsrc1       => Rsrc1 ,
                        Rsrc2       => Rsrc2 ,
                        Rwad        => Rwad  ,
                        M2R         => M2R   ,
                        RW          => RW    ,
                        AW          => AW    ,
                        BW          => BW    ,
                        SH_amt      => SH_amt,
                        SH_in      => SH_in,
                        SH_opc      => SH_opc,
                        S_ctrl      => S_ctrl,
                        M_ctrl      => M_ctrl,
                        Asrc1       => Asrc1 ,
                        Asrc2       => Asrc2 ,
                        REW         => REW   ,
                        F_set       => F_set ,
                        C_set       => C_set ,
                        C_ch        => C_ch  

        );

    ctrl : entity work.controller
        port map(
                instr      => instr,  
                clk         => clock,
                flags   => flags,
                
                OP          => OP,
                
                PW          => PW,
                IorD        => IorD,
                MemW        => MemW,
                PM_opc      => PM_opc,
                PM_off      => PM_off,
                IW          => IW    ,
                DW          => DW    ,
                Rsrc1       => Rsrc1 ,
                Rsrc2       => Rsrc2 ,
                Rwad        => Rwad  ,
                M2R         => M2R   ,
                RW          => RW    ,
                AW          => AW    ,
                BW          => BW    ,
                SH_amt      => SH_amt,
                SH_in       => SH_in,
                SH_opc      => SH_opc,
                S_ctrl      => S_ctrl,
                M_ctrl      => M_ctrl,
                Asrc1       => Asrc1 ,
                Asrc2       => Asrc2 ,
                REW         => REW   ,
                F_set       => F_set ,
                C_set       => C_set ,
                C_ch        => C_ch  

                );
              

end Behavioral;
