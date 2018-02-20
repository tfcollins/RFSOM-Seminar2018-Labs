-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_ACSUnit.vhd
-- Created: 2018-02-01 13:20:10
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_ACSUnit
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/Viterbi Decode/Viterbi Decoder/ACS/ACSEngine/ACSUnit
-- Hierarchy Level: 6
-- 
-- Add Compare Select Unit
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_ACSUnit IS
  PORT( bmet0                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        bmet1                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        smet0                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        smet1                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        branchdec                         :   OUT   std_logic;  -- ufix1
        nextsmet                          :   OUT   std_logic_vector(4 DOWNTO 0)  -- ufix5
        );
END CombinedT_ip_src_ACSUnit;


ARCHITECTURE rtl OF CombinedT_ip_src_ACSUnit IS

  -- Signals
  SIGNAL bmet0_unsigned                   : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL smet0_unsigned                   : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL sum0                             : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL bmet1_unsigned                   : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL smet1_unsigned                   : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL sum1                             : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL relop_relop1                     : std_logic;
  SIGNAL nextsmet_tmp                     : unsigned(4 DOWNTO 0);  -- ufix5

BEGIN
  bmet0_unsigned <= unsigned(bmet0);

  smet0_unsigned <= unsigned(smet0);

  -- Add branch metric and state metric
  sum0 <= bmet0_unsigned + smet0_unsigned;

  bmet1_unsigned <= unsigned(bmet1);

  smet1_unsigned <= unsigned(smet1);

  -- Add branch metric and state metric
  sum1 <= bmet1_unsigned + smet1_unsigned;

  -- Compare
  
  relop_relop1 <= '1' WHEN sum0 > sum1 ELSE
      '0';

  branchdec <= relop_relop1;

  -- Select
  
  nextsmet_tmp <= sum0 WHEN relop_relop1 = '0' ELSE
      sum1;

  nextsmet <= std_logic_vector(nextsmet_tmp);

END rtl;

