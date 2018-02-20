-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_StandardIQ\CombinedT_ip_src_Mod_1.vhd
-- Created: 2018-02-01 11:49:52
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Mod_1
-- Source Path: combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Frame Recover/Gardner Timing Recovery/InterpControl_Blocks1/Mod 
-- 
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Mod_1 IS
  PORT( In1                               :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        Out1                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- ufix16_En16
        );
END CombinedT_ip_src_Mod_1;


ARCHITECTURE rtl OF CombinedT_ip_src_Mod_1 IS

  -- Signals
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL In1_unsigned                     : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL Constant_out1                    : std_logic;  -- ufix1
  SIGNAL Subtract_sub_cast                : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Subtract_out1                    : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Switch_out1                      : unsigned(15 DOWNTO 0);  -- ufix16_En16

BEGIN
  Compare_To_Constant1_out1 <= '1';

  In1_unsigned <= unsigned(In1);

  
  Compare_To_Constant_out1 <= '1' WHEN In1_unsigned < to_unsigned(16#FFFF#, 16) ELSE
      '0';

  Logical_Operator_out1 <= Compare_To_Constant1_out1 AND Compare_To_Constant_out1;

  
  switch_compare_1 <= '1' WHEN Logical_Operator_out1 > '0' ELSE
      '0';

  Constant_out1 <= '1';

  Subtract_sub_cast <= to_unsigned(16#0000#, 16);
  Subtract_out1 <= In1_unsigned - Subtract_sub_cast;

  
  Switch_out1 <= Subtract_out1 WHEN switch_compare_1 = '0' ELSE
      In1_unsigned;

  Out1 <= std_logic_vector(Switch_out1);

END rtl;

