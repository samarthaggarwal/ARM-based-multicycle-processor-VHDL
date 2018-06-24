----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 22:06:40
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
  Port (
        instr       :       in std_logic_vector(31 downto 0);
        clk         :       in std_logic;
        flags   :       in std_logic_vector(3 downto 0);
        
        OP          :       out std_logic_vector(3 downto 0);    -- alu opcode
        
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
end controller;

architecture Behavioral of controller is

component actrl
  Port (
    ins         :       in std_logic_vector(3 downto 0);     -- ins[24 - 21]
    state       :       in integer;
    
    op          :       out std_logic_vector(3 downto 0)
    
   );
end component;

component bctrl
  Port ( 
    z   :   in std_logic;
    n   :   in std_logic;
    c   :   in std_logic;
    v   :   in std_logic;
    ins :   in std_logic_vector(3 downto 0); --ins[31 - 28]
        
    p   :   out std_logic
  );
end component;

component ins_decoder
    Port ( ins : in STD_LOGIC_VECTOR (31 downto 0);

            class       :       out std_logic_vector(1 downto 0);
            dp_ctg  :       out std_logic_vector(1 downto 0);
            dt_ctg  :       out std_logic_vector(2 downto 0);
            variant :       out std_logic_vector(1 downto 0);
            unimplemented   :   out std_logic;
            undefined       :   out std_logic;
            mla             :   out std_logic;  -- 1 for mla, 0 for mul
            shift           :   out std_logic;  -- 1 for shift, 0 for no shift
            shift_reg       :   out std_logic;   -- 1 if shift amount is specified in register, 0 if shift amt is specified as immediate
            shift_op        :   out std_logic_vector(1 downto 0);   -- opcode for shifter
            L               :   out std_logic;   -- 1 for bl, 0 for b
            pm_off          :   out std_logic_vector(1 downto 0)
        );
end component;

component ctrlSigGen
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
end component;

component ctrlFSM
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
end component;

    signal curr_state,next_state       :       integer;
    signal p,mla,shift,shift_reg,L,unimplemented, undefined          :       std_logic;
    signal class,dp_ctg, variant,shift_op,pm_off1        :   std_logic_vector(1 downto 0);
    signal dt_ctg       :       std_logic_vector(2 downto 0);
    


begin

    a_controller : actrl
        port map(
            ins => instr(24 downto 21),
            state => curr_state,
            op => OP
        );
        
    b_controller : bctrl
        port map(
            z => flags(3),
            n => flags(2),
            v => flags(1),
            c => flags(0),
            ins => instr(31 downto 28),
            p => p
        );
        
    ins_dec : ins_decoder
        port map(
            ins => instr,
            class => class,
            dp_ctg => dp_ctg,
            dt_ctg => dt_ctg,
            variant => variant,
            unimplemented => unimplemented,
            undefined => undefined,
            mla => mla,
            shift => shift,
            shift_reg => shift_reg,
            shift_op => shift_op,
            L => L,
            pm_off => pm_off1
        );
        
    control_signal_gen : ctrlSigGen
        port map(
            state => curr_state,
            I24   => L,
            I21   => mla,
            shift_op    => shift_op,
            p       => p,
            pm_op      => dt_ctg, 
            pm_offset   => pm_off1,
    
            PW        => PW,
            IorD     => IorD,
            MemW       => MemW,
            PM_opc      => PM_opc,
            PM_off      => PM_off,
            IW      => IW,
            DW         => DW,
            Rsrc1      => Rsrc1,
            Rsrc2    => Rsrc2,
            Rwad       => Rwad,
            M2R      => M2R,
            RW       => RW,
            AW      => AW,
            BW       => BW,
            SH_amt   => SH_amt,
            SH_opc  => SH_opc,
            S_ctrl    => S_ctrl,
            M_ctrl   => M_ctrl,
            Asrc1    => Asrc1,
            Asrc2    => Asrc2,
                --        op          :       out std_logic_vector(3 downto 0);     -- op for alu is handles by Actrl
            REW      => REW,
            F_set    =>F_set,
            C_set   => C_set,  
            C_ch   => C_ch
        );
        
    FSM : ctrlFSM
        port map(
            curr_state    => curr_state,
            clk          => clk,   
            class      => class,
              mla     => mla,
              shift   => shift,
              shift_reg     => shift_reg,
              L        => L,
    
            next_state  => next_state
        );
        
    curr_state <= next_state;   
        
end Behavioral;
