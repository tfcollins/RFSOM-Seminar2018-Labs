-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_QPSK_Modulator_Baseband.vhd
-- Created: 2018-02-01 18:12:06
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_QPSK_Modulator_Baseband
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Frame Recover/Equalization and Demodulation/DFE/QPSK 
-- Modulator Baseban
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_QPSK_Modulator_Baseband IS
  PORT( in0                               :   IN    std_logic_vector(0 TO 1);  -- ufix1 [2]
        out0_re                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        out0_im                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
        );
END CombinedT_ip_src_QPSK_Modulator_Baseband;


ARCHITECTURE rtl OF CombinedT_ip_src_QPSK_Modulator_Baseband IS

  -- Constants
  CONSTANT t1_re                          : vector_of_signed16(0 TO 3) := 
    (to_signed(16#5A82#, 16), to_signed(-16#5A82#, 16), to_signed(-16#5A82#, 16), to_signed(16#5A82#, 16));  -- sfix16 [4]
  CONSTANT t1_im                          : vector_of_signed16(0 TO 3) := 
    (to_signed(16#5A82#, 16), to_signed(16#5A82#, 16), to_signed(-16#5A82#, 16), to_signed(-16#5A82#, 16));  -- sfix16 [4]

  -- Signals
  SIGNAL constellationLUTaddress          : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL out0_re_tmp                      : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL out0_im_tmp                      : signed(15 DOWNTO 0);  -- sfix16_En15

BEGIN
  constellationLUTaddress <= unsigned'(in0(0) & in0(1));

  out0_re_tmp <= t1_re(to_integer(constellationLUTaddress));
  out0_im_tmp <= t1_im(to_integer(constellationLUTaddress));

  out0_re <= std_logic_vector(out0_re_tmp);

  out0_im <= std_logic_vector(out0_im_tmp);

END rtl;

