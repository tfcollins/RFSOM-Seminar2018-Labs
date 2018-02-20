-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_Packeted_To_Unpacked.vhd
-- Created: 2018-02-01 13:20:09
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Packeted_To_Unpacked
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/Frame Recover/Equalization and Demodulation/DFE/Packeted 
-- To Unpacke
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Packeted_To_Unpacked IS
  PORT( In1                               :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        Out1                              :   OUT   std_logic_vector(0 TO 1)  -- ufix1 [2]
        );
END CombinedT_ip_src_Packeted_To_Unpacked;


ARCHITECTURE rtl OF CombinedT_ip_src_Packeted_To_Unpacked IS

  -- Signals
  SIGNAL In1_unsigned                     : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Extract_Bits_out1                : std_logic;  -- ufix1
  SIGNAL dtc1                             : std_logic;  -- ufix1
  SIGNAL Extract_Bits1_out1               : std_logic;  -- ufix1
  SIGNAL Vector_Concatenate_out1          : std_logic_vector(0 TO 1);  -- ufix1 [2]

BEGIN
  In1_unsigned <= unsigned(In1);

  Extract_Bits_out1 <= In1_unsigned(1);

  dtc1 <= In1_unsigned(0);

  Extract_Bits1_out1 <= dtc1;

  Vector_Concatenate_out1(0) <= Extract_Bits_out1;
  Vector_Concatenate_out1(1) <= Extract_Bits1_out1;

  Out1 <= Vector_Concatenate_out1;

END rtl;

