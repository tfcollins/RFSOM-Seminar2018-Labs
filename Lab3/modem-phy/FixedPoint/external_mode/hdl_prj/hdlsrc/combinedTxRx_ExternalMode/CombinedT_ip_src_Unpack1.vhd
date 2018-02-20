-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_Unpack1.vhd
-- Created: 2018-02-01 13:20:10
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Unpack1
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Transmitter HDL/Packet Generation/Preamble/Unpack1
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Unpack1 IS
  PORT( In1                               :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        Out1                              :   OUT   std_logic_vector(0 TO 1)  -- boolean [2]
        );
END CombinedT_ip_src_Unpack1;


ARCHITECTURE rtl OF CombinedT_ip_src_Unpack1 IS

  -- Signals
  SIGNAL In1_unsigned                     : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Extract_Bits_out1                : std_logic;  -- ufix1
  SIGNAL dtc1                             : std_logic;  -- ufix1
  SIGNAL Extract_Bits1_out1               : std_logic;  -- ufix1
  SIGNAL Vector_Concatenate_out1          : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Data_Type_Conversion_out1        : std_logic_vector(0 TO 1);  -- boolean [2]

BEGIN
  In1_unsigned <= unsigned(In1);

  Extract_Bits_out1 <= In1_unsigned(1);

  dtc1 <= In1_unsigned(0);

  Extract_Bits1_out1 <= dtc1;

  Vector_Concatenate_out1(0) <= Extract_Bits_out1;
  Vector_Concatenate_out1(1) <= Extract_Bits1_out1;

  
  Data_Type_Conversion_out1(0) <= '1' WHEN Vector_Concatenate_out1(0) /= '0' ELSE
      '0';
  
  Data_Type_Conversion_out1(1) <= '1' WHEN Vector_Concatenate_out1(1) /= '0' ELSE
      '0';

  Out1 <= Data_Type_Conversion_out1;

END rtl;

