-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_TED_Buffer_Update1.vhd
-- Created: 2018-02-01 13:20:09
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_TED_Buffer_Update1
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/Frame Recover/Gardner Timing Recovery/Gardner 
-- TED Blocks/Imag Error/TED Buffer Update
-- Hierarchy Level: 6
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_TED_Buffer_Update1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        new_data                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
        strobe_sum                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        Enable_out2                       :   IN    std_logic;
        Middle_Indx                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
        oldest                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En10
        );
END CombinedT_ip_src_TED_Buffer_Update1;


ARCHITECTURE rtl OF CombinedT_ip_src_TED_Buffer_Update1 IS

  -- Signals
  SIGNAL strobe_sum_unsigned              : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL enb_gated                        : std_logic;
  SIGNAL new_data_signed                  : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL enb_gated_1                      : std_logic;
  SIGNAL Delay3_out1                      : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Multiport_Switch3_out1           : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Zero_bit_out1                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Zero_bit_out1_dtc                : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Multiport_Switch2_out1           : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Delay2_out1                      : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL enb_gated_2                      : std_logic;
  SIGNAL enb_gated_3                      : std_logic;
  SIGNAL Delay1_out1                      : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Multiport_Switch1_out1           : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Multiport_Switch_out1            : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Delay_out1                       : signed(15 DOWNTO 0);  -- sfix16_En10

BEGIN
  strobe_sum_unsigned <= unsigned(strobe_sum);

  enb_gated <= Enable_out2 AND enb;

  new_data_signed <= signed(new_data);

  enb_gated_1 <= Enable_out2 AND enb;

  
  Multiport_Switch3_out1 <= Delay3_out1 WHEN strobe_sum_unsigned = to_unsigned(16#00#, 8) ELSE
      new_data_signed WHEN strobe_sum_unsigned = to_unsigned(16#01#, 8) ELSE
      new_data_signed;

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated_1 = '1' THEN
        Delay3_out1 <= Multiport_Switch3_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Zero_bit_out1 <= to_signed(16#0000#, 16);

  Zero_bit_out1_dtc <= resize(Zero_bit_out1(15 DOWNTO 3), 16);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated = '1' THEN
        Delay2_out1 <= Multiport_Switch2_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  
  Multiport_Switch2_out1 <= Delay2_out1 WHEN strobe_sum_unsigned = to_unsigned(16#00#, 8) ELSE
      Delay3_out1 WHEN strobe_sum_unsigned = to_unsigned(16#01#, 8) ELSE
      Zero_bit_out1_dtc;

  Middle_Indx <= std_logic_vector(Multiport_Switch2_out1);

  enb_gated_2 <= Enable_out2 AND enb;

  enb_gated_3 <= Enable_out2 AND enb;

  
  Multiport_Switch1_out1 <= Delay1_out1 WHEN strobe_sum_unsigned = to_unsigned(16#00#, 8) ELSE
      Delay2_out1 WHEN strobe_sum_unsigned = to_unsigned(16#01#, 8) ELSE
      Delay3_out1;

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated_3 = '1' THEN
        Delay1_out1 <= Multiport_Switch1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated_2 = '1' THEN
        Delay_out1 <= Multiport_Switch_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  
  Multiport_Switch_out1 <= Delay_out1 WHEN strobe_sum_unsigned = to_unsigned(16#00#, 8) ELSE
      Delay1_out1 WHEN strobe_sum_unsigned = to_unsigned(16#01#, 8) ELSE
      Delay2_out1;

  oldest <= std_logic_vector(Multiport_Switch_out1);

END rtl;
