-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_Frequency_Recovery.vhd
-- Created: 2018-02-01 18:12:06
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Frequency_Recovery
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Frame Recover/Frequency Recovery
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Frequency_Recovery IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
        validIn                           :   IN    std_logic;
        LoopBW                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        Enable                            :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        validOut                          :   OUT   std_logic;
        lock                              :   OUT   std_logic
        );
END CombinedT_ip_src_Frequency_Recovery;


ARCHITECTURE rtl OF CombinedT_ip_src_Frequency_Recovery IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_PED
    PORT( In_re                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          In_im                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          e                               :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En10
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Loop_Filter_Configurable
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          e                               :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          LoopBW                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          Enable_out4                     :   IN    std_logic;
          v                               :   OUT   std_logic_vector(24 DOWNTO 0)  -- sfix25_En20
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Phase_Shift_FP
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          Phi                             :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En20
          Out1_re                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Out1_im                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En13
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Lock_Detector
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ped                             :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          Enable_out4                     :   IN    std_logic;
          lock                            :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_PED
    USE ENTITY work.CombinedT_ip_src_PED(rtl);

  FOR ALL : CombinedT_ip_src_Loop_Filter_Configurable
    USE ENTITY work.CombinedT_ip_src_Loop_Filter_Configurable(rtl);

  FOR ALL : CombinedT_ip_src_Phase_Shift_FP
    USE ENTITY work.CombinedT_ip_src_Phase_Shift_FP(rtl);

  FOR ALL : CombinedT_ip_src_Lock_Detector
    USE ENTITY work.CombinedT_ip_src_Lock_Detector(rtl);

  -- Signals
  SIGNAL Enable_out4                      : std_logic;
  SIGNAL enb_gated                        : std_logic;
  SIGNAL Phase_Shift_FP_out1_im           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Phase_Shift_FP_out1_im_signed    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Delay_out1_im                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Delay_out1_re                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL e                                : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Loop_Filter_Configurable_out1    : std_logic_vector(24 DOWNTO 0);  -- ufix25
  SIGNAL Phase_Shift_FP_out1_re           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Phase_Shift_FP_out1_re_signed    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Lock_Detector_out1               : std_logic;

BEGIN
  -- Decrease Loop bandwidth to reduce phase noise,
  -- but worse pull-in range
  -- -0.1 30kHz pull-in
  -- -0.01 5kHz pull-in
  -- 
  -- Max Phase Lock Delay= 1.3/(NormLoopBandwidth*SampleRate)
  -- 
  -- Frequency Lock Delay = SampleRate*4*NormalizedPullInRange^2)/ (SampleRate*NormLoopBandwidth)^3;
  -- 
  -- Pull in range (Hz) = 2*pi*sqrt(2)*DampingFactor*NormLoopBandwidth*SampleRate

  u_PED : CombinedT_ip_src_PED
    PORT MAP( In_re => std_logic_vector(Delay_out1_re),  -- sfix16_En13
              In_im => std_logic_vector(Delay_out1_im),  -- sfix16_En13
              e => e  -- sfix16_En10
              );

  u_Loop_Filter_Configurable : CombinedT_ip_src_Loop_Filter_Configurable
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              e => e,  -- sfix16_En10
              LoopBW => LoopBW,  -- int16
              Enable_out4 => Enable_out4,
              v => Loop_Filter_Configurable_out1  -- sfix25_En20
              );

  u_Phase_Shift_FP : CombinedT_ip_src_Phase_Shift_FP
    PORT MAP( In1_re => dataIn_re,  -- sfix16_En10
              In1_im => dataIn_im,  -- sfix16_En10
              Phi => Loop_Filter_Configurable_out1,  -- sfix25_En20
              Out1_re => Phase_Shift_FP_out1_re,  -- sfix16_En13
              Out1_im => Phase_Shift_FP_out1_im  -- sfix16_En13
              );

  u_Lock_Detector : CombinedT_ip_src_Lock_Detector
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ped => e,  -- sfix16_En10
              Enable_out4 => Enable_out4,
              lock => Lock_Detector_out1
              );

  Enable_out4 <= Enable;

  enb_gated <= Enable_out4 AND enb;

  Phase_Shift_FP_out1_im_signed <= signed(Phase_Shift_FP_out1_im);

  Phase_Shift_FP_out1_re_signed <= signed(Phase_Shift_FP_out1_re);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1_re <= to_signed(16#0000#, 16);
      Delay_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated = '1' THEN
        Delay_out1_re <= Phase_Shift_FP_out1_re_signed;
        Delay_out1_im <= Phase_Shift_FP_out1_im_signed;
      END IF;
    END IF;
  END PROCESS Delay_process;


  dataOut_re <= std_logic_vector(Delay_out1_re);

  dataOut_im <= std_logic_vector(Delay_out1_im);

  validOut <= validIn;

  lock <= Lock_Detector_out1;

END rtl;

