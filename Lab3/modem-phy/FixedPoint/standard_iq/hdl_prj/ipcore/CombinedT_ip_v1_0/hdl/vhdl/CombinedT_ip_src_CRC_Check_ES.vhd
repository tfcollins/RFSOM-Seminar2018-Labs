-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_StandardIQ\CombinedT_ip_src_CRC_Check_ES.vhd
-- Created: 2018-02-01 11:49:52
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_CRC_Check_ES
-- Source Path: combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/CRC Check and DMA Pack/CRC Check ES
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_CRC_Check_ES IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Valid                             :   IN    std_logic;
        Bits                              :   IN    std_logic;
        endCRC                            :   IN    std_logic;
        StartData                         :   IN    std_logic;
        payloadLen                        :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        dataOut                           :   OUT   std_logic;  -- ufix1
        startOut                          :   OUT   std_logic;
        endOut                            :   OUT   std_logic;
        validOut                          :   OUT   std_logic;
        err                               :   OUT   std_logic;
        payloadLenOut                     :   OUT   std_logic_vector(15 DOWNTO 0)  -- uint16
        );
END CombinedT_ip_src_CRC_Check_ES;


ARCHITECTURE rtl OF CombinedT_ip_src_CRC_Check_ES IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn                          :   IN    std_logic;  -- ufix1
          startIn                         :   IN    std_logic;
          endIn                           :   IN    std_logic;
          validIn                         :   IN    std_logic;
          dataOut                         :   OUT   std_logic;  -- ufix1
          startOut                        :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic;
          err                             :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized
    USE ENTITY work.CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized(rtl);

  -- Signals
  SIGNAL Convert_To_fi_out1               : std_logic;  -- ufix1
  SIGNAL delayMatch_reg                   : std_logic_vector(0 TO 19);  -- ufix1 [20]
  SIGNAL StartData_1                      : std_logic;
  SIGNAL delayMatch1_reg                  : std_logic_vector(0 TO 19);  -- ufix1 [20]
  SIGNAL endCRC_1                         : std_logic;
  SIGNAL delayMatch2_reg                  : std_logic_vector(0 TO 19);  -- ufix1 [20]
  SIGNAL Valid_1                          : std_logic;
  SIGNAL General_CRC_Syndrom_Detector_HDL_Optimized_out1 : std_logic;  -- ufix1
  SIGNAL General_CRC_Syndrom_Detector_HDL_Optimized_out2 : std_logic;
  SIGNAL General_CRC_Syndrom_Detector_HDL_Optimized_out3 : std_logic;
  SIGNAL General_CRC_Syndrom_Detector_HDL_Optimized_out4 : std_logic;
  SIGNAL General_CRC_Syndrom_Detector_HDL_Optimized_out5 : std_logic;
  SIGNAL payloadLen_unsigned              : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL CRC_Decode_Lag_reg               : vector_of_unsigned16(0 TO 33);  -- ufix16 [34]
  SIGNAL CRC_Decode_Lag_out1              : unsigned(15 DOWNTO 0);  -- uint16

BEGIN
  -- NOTE:
  -- 	The Valid signal must be latched during a packet, which is 
  -- 	a bug (2018a Fixed).

  u_General_CRC_Syndrom_Detector_HDL_Optimized : CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn => Convert_To_fi_out1,  -- ufix1
              startIn => StartData_1,
              endIn => endCRC_1,
              validIn => Valid_1,
              dataOut => General_CRC_Syndrom_Detector_HDL_Optimized_out1,  -- ufix1
              startOut => General_CRC_Syndrom_Detector_HDL_Optimized_out2,
              endOut => General_CRC_Syndrom_Detector_HDL_Optimized_out3,
              validOut => General_CRC_Syndrom_Detector_HDL_Optimized_out4,
              err => General_CRC_Syndrom_Detector_HDL_Optimized_out5
              );

  Convert_To_fi_out1 <= Bits;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= StartData;
        delayMatch_reg(1 TO 19) <= delayMatch_reg(0 TO 18);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  StartData_1 <= delayMatch_reg(19);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= endCRC;
        delayMatch1_reg(1 TO 19) <= delayMatch1_reg(0 TO 18);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  endCRC_1 <= delayMatch1_reg(19);

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch2_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch2_reg(0) <= Valid;
        delayMatch2_reg(1 TO 19) <= delayMatch2_reg(0 TO 18);
      END IF;
    END IF;
  END PROCESS delayMatch2_process;

  Valid_1 <= delayMatch2_reg(19);

  payloadLen_unsigned <= unsigned(payloadLen);

  CRC_Decode_Lag_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CRC_Decode_Lag_reg <= (OTHERS => to_unsigned(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        CRC_Decode_Lag_reg(0) <= payloadLen_unsigned;
        CRC_Decode_Lag_reg(1 TO 33) <= CRC_Decode_Lag_reg(0 TO 32);
      END IF;
    END IF;
  END PROCESS CRC_Decode_Lag_process;

  CRC_Decode_Lag_out1 <= CRC_Decode_Lag_reg(33);

  payloadLenOut <= std_logic_vector(CRC_Decode_Lag_out1);

  dataOut <= General_CRC_Syndrom_Detector_HDL_Optimized_out1;

  startOut <= General_CRC_Syndrom_Detector_HDL_Optimized_out2;

  endOut <= General_CRC_Syndrom_Detector_HDL_Optimized_out3;

  validOut <= General_CRC_Syndrom_Detector_HDL_Optimized_out4;

  err <= General_CRC_Syndrom_Detector_HDL_Optimized_out5;

END rtl;

