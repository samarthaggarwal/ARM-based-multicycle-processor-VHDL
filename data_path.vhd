----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2018 13:31:24
-- Design Name: 
-- Module Name: data_path - Behavioral
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

entity pm_ex is
    Port ( operand1 : in STD_LOGIC_VECTOR (11 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0));
end pm_ex;

architecture Behavioral of pm_ex is

signal res : std_logic_vector(31 downto 0);

begin

    res(11 downto 0) <= operand1(11 downto 0);
    res(31 downto 12) <= (others => operand1(11));
    result <= res;

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
Use Ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity data_path is
    Port (  PW : in std_logic;
            IorD : in std_logic_vector(1 downto 0); 
--            MR : in std_logic;
            MemW : in std_logic;
            IW : in std_logic;
            DW : in std_logic;
            Rsrc2 : in std_logic :='0';
            Rsrc1 : in std_logic :='0';
            Rwad    :   in std_logic_vector(1 downto 0);
            M2R : in std_logic_vector(1 downto 0);
            BW : in std_logic;
            RW : in std_logic;
            AW : in std_logic ;                 
            Asrc1 : in std_logic_vector(1 downto 0);
            Asrc2 : in std_logic_vector(2 downto 0);
            F_set : in std_logic;
            C_set : in std_logic;   
            C_ch    : in std_logic;
            ReW : in std_logic;
            op : in std_logic_vector(3 downto 0); 
            SH_OPC : in std_logic_vector(1 downto 0);
            SH_amt  : in std_logic;
            S_CTRL : in std_logic;
            M_CTRL : in std_logic;
            PM_OPC : in std_logic_vector(2 downto 0);
            PM_OFF : in std_logic_vector(1 downto 0);
            clk : in std_logic ;
            flags :  out std_logic_vector(3 downto 0);
            instr : out std_logic_vector(31 downto 0)
            );
            
end data_path;

architecture Behavioral of data_path is

    signal IR : std_logic_vector (31 downto 0);
    signal DR : std_logic_vector (31 downto 0);
    signal A : std_logic_vector (31 downto 0);
    signal B : std_logic_vector (31 downto 0);
    signal RES : std_logic_vector (31 downto 0);
    signal F : std_logic_vector (3 downto 0);
    
    signal rad1 : std_logic_vector(3 downto 0);
    signal rad2 : std_logic_vector(3 downto 0);
    signal wad : std_logic_vector(3 downto 0);
    signal wd : std_logic_vector(31 downto 0);
    
    signal rd1 : std_logic_vector(31 downto 0);
    signal rd2 : std_logic_vector(31 downto 0);
    
    signal pc : std_logic_vector(31 downto 0);
    
    signal ins : std_logic_vector(31 downto 0); 
    
    signal dts : std_logic_vector(31 downto 0); 
    
    signal alu_op1 : std_logic_vector(31 downto 0); 
    signal alu_op2 : std_logic_vector(31 downto 0); 
    signal alu_op2_ex : std_logic_vector(31 downto 0); 
    signal alu_op2_s2_help : std_logic_vector(31 downto 0); 
    signal alu_op2_s2 : std_logic_vector(31 downto 0); 
    
    signal temp_F : std_logic_vector (3 downto 0);
    signal temp_C : std_logic;
    signal temp_c1 : std_logic;
    signal temp_c2 : std_logic;
        
    signal temp_RES : std_logic_vector (31 downto 0);
    
    signal wd_mem : std_logic_vector (31 downto 0);
    signal rd_mem : std_logic_vector (31 downto 0);
    signal ad_mem : std_logic_vector (31 downto 0);
    
    signal pm_write_en : std_logic_vector (3 downto 0);
    
    signal S : std_logic_vector (31 downto 0);
    
    signal M : std_logic_vector (31 downto 0);
    
    signal temp_S : std_logic_vector (31 downto 0);
        
    signal temp_M : std_logic_vector (31 downto 0);
    

begin

    mem: entity work.memory	port map(
		clk				=> clk,
		reset 			=> '0',
		write_enable	=> pm_write_en,  --MW,
		wr_data			=> wd_mem,
		addr			=> ad_mem,
		rd_data		    => rd_mem
	);

    rf1: entity work.register_file(behavioral) port map(
		clk				=> clk,
		reset 			=> '0',
		write_enable	=> RW,
		wr_data			=> wd,
		wr_addr			=> wad,
		rd_addr1		=> rad1,
		rd_addr2		=> rad2,
		pc_enable       => PW,
		pc_data         => RES,

		rd_data1		=> rd1,
		rd_data2		=> rd2,
		pc_out			=> pc
	);
	
	alu1 : entity work.alu PORT MAP
	         ( operand1 => alu_op1,
               operand2 => alu_op2,
               carry => F(0),
               optype => op,
               result => temp_RES,
               flags => temp_F);
               
    p_m_path1 : entity work.p_m_path Port map
                        ( in_p => rd1,
                          in_m => DR,
                          opcode => PM_OPC,
                          offset => PM_OFF,
                          out_p => wd,
                          out_m => wd_mem,
                          write_en => pm_write_en);
                          
    multiplier1 : entity work.multiplier 
                  Port map (    operand1 => A,
                                operand2 => B,
                                cflag => temp_c2,
                                result => temp_M);
               
    F <= temp_F when F_set='1' else F;
    flags <= F;
    RES <= temp_RES when ReW='1' else RES;
    
    F(1)    <=  temp_C when C_set = '1' else F(1);
    
    temp_C <= temp_c1 when C_ch = '0' else temp_c2;
               
    pm_ex1 : entity work.pm_ex Port Map ( 
                            operand1 => IR(11 downto 0),
                            result => alu_op2_ex);
                            
    alu_op2_s2_help <=  "00000000" & IR(23 downto 0) ;
                            
    shifter1 : entity work.shifter 
                Port map ( input => alu_op2_s2_help,
                       amount => "0010",
                       opcode => "00",
                       output => alu_op2_s2 );
                       
    shifter2 : entity work.shifter 
               Port map ( input => B,
                      amount => A,
                      opcode => SH_OPC,
                      carry => temp_c1,
                      output => temp_S );
                      
    S <= temp_S when S_CTRL='1' else S;
    
    M <= temp_M when M_CTRL='1' else M;
               
    alu_op1 <= pc when Asrc1="00" else A when Asrc1="01" else M;
    alu_op2 <= B when Asrc2="000" else "00000000000000000000000000000100" when Asrc2="001"
                 else alu_op2_ex when Asrc2="010" else alu_op2_s2 when Asrc2="011" else S when Asrc2="100" else (others => '0');
    
    rad1 <= ins(19 downto 16) when (Rsrc1 = '0') else ins(11 downto 8);
    rad2(3 downto 0) <= IR(3 downto 0) when (Rsrc2 = '0') else IR(15 downto 12); 
    wd(31 downto 0) <= DR(31 downto 0) when (M2R = "01") else RES(15 downto 12) when (M2R = "00") else M when (M2R = "10")else PC; 
    A <= rd1 when (AW='1') else A;
    B <= rd1 when (BW='1') else B;
    
    IR <= rd_mem when (IW='1') else IR;
    DR <= rd_mem when (DW='1') else DR;
    
    ad_mem <= pc when (IorD="00") else RES when (IorD = "01") else A;
    wd_mem <= B;
    
    instr <= pc;
    
--process (clk)
--begin

--end process;
	
end Behavioral;
