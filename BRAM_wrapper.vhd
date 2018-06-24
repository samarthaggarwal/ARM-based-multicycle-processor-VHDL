--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
--Date        : Tue Mar  6 16:26:02 2018
--Host        : ayush-Aspire-E5-573G running 64-bit Ubuntu 16.04.3 LTS
--Command     : generate_target BRAM_wrapper.bd
--Design      : BRAM_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BRAM_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_rst : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end BRAM_wrapper;

architecture STRUCTURE of BRAM_wrapper is
  component BRAM is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_rst : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component BRAM;
begin
BRAM_i: component BRAM
     port map (
      BRAM_PORTA_addr(31 downto 0) => BRAM_PORTA_addr(31 downto 0),
      BRAM_PORTA_clk => BRAM_PORTA_clk,
      BRAM_PORTA_din(31 downto 0) => BRAM_PORTA_din(31 downto 0),
      BRAM_PORTA_dout(31 downto 0) => BRAM_PORTA_dout(31 downto 0),
      BRAM_PORTA_en => BRAM_PORTA_en,
      BRAM_PORTA_rst => BRAM_PORTA_rst,
      BRAM_PORTA_we(3 downto 0) => BRAM_PORTA_we(3 downto 0)
    );
end STRUCTURE;
