-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized.vhd
-- Created: 2018-02-01 13:20:08
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/CRC Check and DMA Pack/CRC Check ES/General 
-- CRC Syndrom Detector HDL Optimize
-- Hierarchy Level: 4
-- 
-- CRC Syndrome Detector HDL Optimized
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn                            :   IN    std_logic;  -- ufix1
        startIn                           :   IN    std_logic;
        endIn                             :   IN    std_logic;
        validIn                           :   IN    std_logic;
        dataOut                           :   OUT   std_logic;  -- ufix1
        startOut                          :   OUT   std_logic;
        endOut                            :   OUT   std_logic;
        validOut                          :   OUT   std_logic;
        err                               :   OUT   std_logic
        );
END CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized;


ARCHITECTURE rtl OF CombinedT_ip_src_General_CRC_Syndrom_Detector_HDL_Optimized IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_CRCGenerator
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
          outputCRC                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_CRCCompare
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataRef                         :   IN    std_logic;  -- ufix1
          endIn                           :   IN    std_logic;
          dataOutgen                      :   IN    std_logic;  -- ufix1
          startOutgen                     :   IN    std_logic;
          endOutgen                       :   IN    std_logic;
          validOutgen                     :   IN    std_logic;
          outputCRC                       :   IN    std_logic;
          dataOut                         :   OUT   std_logic;  -- ufix1
          startOut                        :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic;
          err                             :   OUT   std_logic;
          bufferenb                       :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_CRCGenerator
    USE ENTITY work.CombinedT_ip_src_CRCGenerator(rtl);

  FOR ALL : CombinedT_ip_src_CRCCompare
    USE ENTITY work.CombinedT_ip_src_CRCCompare(rtl);

  -- Signals
  SIGNAL end_valid                        : std_logic;
  SIGNAL datain_register_reg              : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL datainreg                        : std_logic;  -- ufix1
  SIGNAL start_valid                      : std_logic;
  SIGNAL startin_register_reg             : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL startinreg                       : std_logic;
  SIGNAL startin_gen                      : std_logic;
  SIGNAL validin_register_reg             : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL validinreg                       : std_logic;
  SIGNAL validin_gen                      : std_logic;
  SIGNAL dataoutgen                       : std_logic;  -- ufix1
  SIGNAL startoutgen                      : std_logic;
  SIGNAL endoutgen                        : std_logic;
  SIGNAL validoutgen                      : std_logic;
  SIGNAL outputcrc                        : std_logic;
  SIGNAL csumbufferenb                    : std_logic;
  SIGNAL csumenb                          : std_logic;
  SIGNAL csum_register_reg                : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL csumreg                          : std_logic;  -- ufix1

BEGIN
  -- HDL CRC Generator
  u_HDLCRCGen_inst : CombinedT_ip_src_CRCGenerator
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn => datainreg,  -- ufix1
              startIn => startin_gen,
              endIn => end_valid,
              validIn => validin_gen,
              dataOut => dataoutgen,  -- ufix1
              startOut => startoutgen,
              endOut => endoutgen,
              validOut => validoutgen,
              outputCRC => outputcrc
              );

  -- Checksum Comparison
  u_ChecksumCompare_inst : CombinedT_ip_src_CRCCompare
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataRef => csumreg,  -- ufix1
              endIn => end_valid,
              dataOutgen => dataoutgen,  -- ufix1
              startOutgen => startoutgen,
              endOutgen => endoutgen,
              validOutgen => validoutgen,
              outputCRC => outputcrc,
              dataOut => dataOut,  -- ufix1
              startOut => startOut,
              endOut => endOut,
              validOut => validOut,
              err => err,
              bufferenb => csumbufferenb
              );

  end_valid <= endIn AND validIn;

  datain_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      datain_register_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF end_valid = '1' THEN
          datain_register_reg <= (OTHERS => '0');
        ELSIF validIn = '1' THEN
          datain_register_reg(0) <= dataIn;
          datain_register_reg(1 TO 31) <= datain_register_reg(0 TO 30);
        END IF;
      END IF;
    END IF;
  END PROCESS datain_register_process;

  datainreg <= datain_register_reg(31);

  start_valid <= startIn AND validIn;

  startin_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      startin_register_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF end_valid = '1' THEN
          startin_register_reg <= (OTHERS => '0');
        ELSIF validIn = '1' THEN
          startin_register_reg(0) <= start_valid;
          startin_register_reg(1 TO 31) <= startin_register_reg(0 TO 30);
        END IF;
      END IF;
    END IF;
  END PROCESS startin_register_process;

  startinreg <= startin_register_reg(31);

  startin_gen <= startinreg AND validIn;

  validin_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      validin_register_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF end_valid = '1' THEN
          validin_register_reg <= (OTHERS => '0');
        ELSIF validIn = '1' THEN
          validin_register_reg(0) <= validIn;
          validin_register_reg(1 TO 31) <= validin_register_reg(0 TO 30);
        END IF;
      END IF;
    END IF;
  END PROCESS validin_register_process;

  validinreg <= validin_register_reg(31);

  validin_gen <= validinreg AND validIn;

  csumenb <= csumbufferenb OR validIn;

  csum_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      csum_register_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND csumenb = '1' THEN
        csum_register_reg(0) <= dataIn;
        csum_register_reg(1 TO 31) <= csum_register_reg(0 TO 30);
      END IF;
    END IF;
  END PROCESS csum_register_process;

  csumreg <= csum_register_reg(31);

END rtl;

