-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_General_CRC_Generator_HDL_Optimized.vhd
-- Created: 2018-02-01 18:12:06
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_General_CRC_Generator_HDL_Optimized
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/Packet Generation/Payload/General CRC Generator 
-- HDL Optimize
-- Hierarchy Level: 4
-- 
-- CRC Generator HDL Optimized
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_General_CRC_Generator_HDL_Optimized IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        dataIn                            :   IN    std_logic;
        startIn                           :   IN    std_logic;
        endIn                             :   IN    std_logic;
        validIn                           :   IN    std_logic;
        dataOut                           :   OUT   std_logic;
        startOut                          :   OUT   std_logic;
        endOut                            :   OUT   std_logic;
        validOut                          :   OUT   std_logic
        );
END CombinedT_ip_src_General_CRC_Generator_HDL_Optimized;


ARCHITECTURE rtl OF CombinedT_ip_src_General_CRC_Generator_HDL_Optimized IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_CRCGenControl_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          startIn                         :   IN    std_logic;
          endIn                           :   IN    std_logic;
          validIn                         :   IN    std_logic;
          startOut                        :   OUT   std_logic;
          processMsg                      :   OUT   std_logic;
          padZero                         :   OUT   std_logic;
          outputCRC                       :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic;
          counter                         :   OUT   std_logic_vector(4 DOWNTO 0);  -- ufix5
          counter_outputCRC               :   OUT   std_logic_vector(4 DOWNTO 0)  -- ufix5
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_CRCGenCompute_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          datainReg                       :   IN    std_logic;
          validIn                         :   IN    std_logic;
          processMsg                      :   IN    std_logic;
          padZero                         :   IN    std_logic;
          counter                         :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          crcChecksum                     :   OUT   std_logic_vector(0 TO 31)  -- boolean [32]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_CRCGenControl_block
    USE ENTITY work.CombinedT_ip_src_CRCGenControl_block(rtl);

  FOR ALL : CombinedT_ip_src_CRCGenCompute_block
    USE ENTITY work.CombinedT_ip_src_CRCGenCompute_block(rtl);

  -- Signals
  SIGNAL startIn_vld                      : std_logic;
  SIGNAL endIn_vld                        : std_logic;
  SIGNAL tstartout                        : std_logic;
  SIGNAL processMsg                       : std_logic;
  SIGNAL padZero                          : std_logic;
  SIGNAL outputCRC                        : std_logic;
  SIGNAL lastfout                         : std_logic;
  SIGNAL validdata                        : std_logic;
  SIGNAL counter                          : std_logic_vector(4 DOWNTO 0);  -- ufix5
  SIGNAL counter_opcrc                    : std_logic_vector(4 DOWNTO 0);  -- ufix5
  SIGNAL const0                           : std_logic;  -- ufix1
  SIGNAL msgenb                           : std_logic;
  SIGNAL datainReg                        : std_logic;
  SIGNAL alpha_reg                        : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL dataBuffer                       : std_logic;  -- ufix1
  SIGNAL counter_opcrc_unsigned           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL crcCheckSum                      : std_logic_vector(0 TO 31);  -- boolean [32]
  SIGNAL crcCheckSum_0                    : std_logic;
  SIGNAL crcCheckSum_1                    : std_logic;
  SIGNAL crcCheckSum_2                    : std_logic;
  SIGNAL crcCheckSum_3                    : std_logic;
  SIGNAL crcCheckSum_4                    : std_logic;
  SIGNAL crcCheckSum_5                    : std_logic;
  SIGNAL crcCheckSum_6                    : std_logic;
  SIGNAL crcCheckSum_7                    : std_logic;
  SIGNAL crcCheckSum_8                    : std_logic;
  SIGNAL crcCheckSum_9                    : std_logic;
  SIGNAL crcCheckSum_10                   : std_logic;
  SIGNAL crcCheckSum_11                   : std_logic;
  SIGNAL crcCheckSum_12                   : std_logic;
  SIGNAL crcCheckSum_13                   : std_logic;
  SIGNAL crcCheckSum_14                   : std_logic;
  SIGNAL crcCheckSum_15                   : std_logic;
  SIGNAL crcCheckSum_16                   : std_logic;
  SIGNAL crcCheckSum_17                   : std_logic;
  SIGNAL crcCheckSum_18                   : std_logic;
  SIGNAL crcCheckSum_19                   : std_logic;
  SIGNAL crcCheckSum_20                   : std_logic;
  SIGNAL crcCheckSum_21                   : std_logic;
  SIGNAL crcCheckSum_22                   : std_logic;
  SIGNAL crcCheckSum_23                   : std_logic;
  SIGNAL crcCheckSum_24                   : std_logic;
  SIGNAL crcCheckSum_25                   : std_logic;
  SIGNAL crcCheckSum_26                   : std_logic;
  SIGNAL crcCheckSum_27                   : std_logic;
  SIGNAL crcCheckSum_28                   : std_logic;
  SIGNAL crcCheckSum_29                   : std_logic;
  SIGNAL crcCheckSum_30                   : std_logic;
  SIGNAL crcCheckSum_31                   : std_logic;
  SIGNAL crcOut                           : std_logic;  -- ufix1
  SIGNAL msgcrc                           : std_logic;  -- ufix1
  SIGNAL tdataout                         : std_logic;  -- ufix1

BEGIN
  u_Controlsignal_inst : CombinedT_ip_src_CRCGenControl_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              startIn => startIn_vld,
              endIn => endIn_vld,
              validIn => validIn,
              startOut => tstartout,
              processMsg => processMsg,
              padZero => padZero,
              outputCRC => outputCRC,
              endOut => lastfout,
              validOut => validdata,
              counter => counter,  -- ufix5
              counter_outputCRC => counter_opcrc  -- ufix5
              );

  u_ComputeCRC_inst : CombinedT_ip_src_CRCGenCompute_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              datainReg => datainReg,
              validIn => validIn,
              processMsg => processMsg,
              padZero => padZero,
              counter => counter,  -- ufix5
              crcChecksum => crcCheckSum  -- boolean [32]
              );

  startIn_vld <= startIn AND validIn;

  endIn_vld <= endIn AND validIn;

  -- Constant Zero
  const0 <= '0';

  msgenb <= processMsg OR padZero;

  datainput_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      datainReg <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        datainReg <= dataIn;
      END IF;
    END IF;
  END PROCESS datainput_register_process;


  -- Buffer Input Data
  c_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      alpha_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' AND msgenb = '1' THEN
        alpha_reg(0) <= datainReg;
        alpha_reg(1 TO 31) <= alpha_reg(0 TO 30);
      END IF;
    END IF;
  END PROCESS c_process;

  dataBuffer <= alpha_reg(31);

  counter_opcrc_unsigned <= unsigned(counter_opcrc);

  -- Select CRC output bits
  crcCheckSum_0 <= crcCheckSum(0);

  -- Select CRC output bits
  crcCheckSum_1 <= crcCheckSum(1);

  -- Select CRC output bits
  crcCheckSum_2 <= crcCheckSum(2);

  -- Select CRC output bits
  crcCheckSum_3 <= crcCheckSum(3);

  -- Select CRC output bits
  crcCheckSum_4 <= crcCheckSum(4);

  -- Select CRC output bits
  crcCheckSum_5 <= crcCheckSum(5);

  -- Select CRC output bits
  crcCheckSum_6 <= crcCheckSum(6);

  -- Select CRC output bits
  crcCheckSum_7 <= crcCheckSum(7);

  -- Select CRC output bits
  crcCheckSum_8 <= crcCheckSum(8);

  -- Select CRC output bits
  crcCheckSum_9 <= crcCheckSum(9);

  -- Select CRC output bits
  crcCheckSum_10 <= crcCheckSum(10);

  -- Select CRC output bits
  crcCheckSum_11 <= crcCheckSum(11);

  -- Select CRC output bits
  crcCheckSum_12 <= crcCheckSum(12);

  -- Select CRC output bits
  crcCheckSum_13 <= crcCheckSum(13);

  -- Select CRC output bits
  crcCheckSum_14 <= crcCheckSum(14);

  -- Select CRC output bits
  crcCheckSum_15 <= crcCheckSum(15);

  -- Select CRC output bits
  crcCheckSum_16 <= crcCheckSum(16);

  -- Select CRC output bits
  crcCheckSum_17 <= crcCheckSum(17);

  -- Select CRC output bits
  crcCheckSum_18 <= crcCheckSum(18);

  -- Select CRC output bits
  crcCheckSum_19 <= crcCheckSum(19);

  -- Select CRC output bits
  crcCheckSum_20 <= crcCheckSum(20);

  -- Select CRC output bits
  crcCheckSum_21 <= crcCheckSum(21);

  -- Select CRC output bits
  crcCheckSum_22 <= crcCheckSum(22);

  -- Select CRC output bits
  crcCheckSum_23 <= crcCheckSum(23);

  -- Select CRC output bits
  crcCheckSum_24 <= crcCheckSum(24);

  -- Select CRC output bits
  crcCheckSum_25 <= crcCheckSum(25);

  -- Select CRC output bits
  crcCheckSum_26 <= crcCheckSum(26);

  -- Select CRC output bits
  crcCheckSum_27 <= crcCheckSum(27);

  -- Select CRC output bits
  crcCheckSum_28 <= crcCheckSum(28);

  -- Select CRC output bits
  crcCheckSum_29 <= crcCheckSum(29);

  -- Select CRC output bits
  crcCheckSum_30 <= crcCheckSum(30);

  -- Select CRC output bits
  crcCheckSum_31 <= crcCheckSum(31);

  
  crcOut <= crcCheckSum_0 WHEN counter_opcrc_unsigned = to_unsigned(16#00#, 5) ELSE
      crcCheckSum_1 WHEN counter_opcrc_unsigned = to_unsigned(16#01#, 5) ELSE
      crcCheckSum_2 WHEN counter_opcrc_unsigned = to_unsigned(16#02#, 5) ELSE
      crcCheckSum_3 WHEN counter_opcrc_unsigned = to_unsigned(16#03#, 5) ELSE
      crcCheckSum_4 WHEN counter_opcrc_unsigned = to_unsigned(16#04#, 5) ELSE
      crcCheckSum_5 WHEN counter_opcrc_unsigned = to_unsigned(16#05#, 5) ELSE
      crcCheckSum_6 WHEN counter_opcrc_unsigned = to_unsigned(16#06#, 5) ELSE
      crcCheckSum_7 WHEN counter_opcrc_unsigned = to_unsigned(16#07#, 5) ELSE
      crcCheckSum_8 WHEN counter_opcrc_unsigned = to_unsigned(16#08#, 5) ELSE
      crcCheckSum_9 WHEN counter_opcrc_unsigned = to_unsigned(16#09#, 5) ELSE
      crcCheckSum_10 WHEN counter_opcrc_unsigned = to_unsigned(16#0A#, 5) ELSE
      crcCheckSum_11 WHEN counter_opcrc_unsigned = to_unsigned(16#0B#, 5) ELSE
      crcCheckSum_12 WHEN counter_opcrc_unsigned = to_unsigned(16#0C#, 5) ELSE
      crcCheckSum_13 WHEN counter_opcrc_unsigned = to_unsigned(16#0D#, 5) ELSE
      crcCheckSum_14 WHEN counter_opcrc_unsigned = to_unsigned(16#0E#, 5) ELSE
      crcCheckSum_15 WHEN counter_opcrc_unsigned = to_unsigned(16#0F#, 5) ELSE
      crcCheckSum_16 WHEN counter_opcrc_unsigned = to_unsigned(16#10#, 5) ELSE
      crcCheckSum_17 WHEN counter_opcrc_unsigned = to_unsigned(16#11#, 5) ELSE
      crcCheckSum_18 WHEN counter_opcrc_unsigned = to_unsigned(16#12#, 5) ELSE
      crcCheckSum_19 WHEN counter_opcrc_unsigned = to_unsigned(16#13#, 5) ELSE
      crcCheckSum_20 WHEN counter_opcrc_unsigned = to_unsigned(16#14#, 5) ELSE
      crcCheckSum_21 WHEN counter_opcrc_unsigned = to_unsigned(16#15#, 5) ELSE
      crcCheckSum_22 WHEN counter_opcrc_unsigned = to_unsigned(16#16#, 5) ELSE
      crcCheckSum_23 WHEN counter_opcrc_unsigned = to_unsigned(16#17#, 5) ELSE
      crcCheckSum_24 WHEN counter_opcrc_unsigned = to_unsigned(16#18#, 5) ELSE
      crcCheckSum_25 WHEN counter_opcrc_unsigned = to_unsigned(16#19#, 5) ELSE
      crcCheckSum_26 WHEN counter_opcrc_unsigned = to_unsigned(16#1A#, 5) ELSE
      crcCheckSum_27 WHEN counter_opcrc_unsigned = to_unsigned(16#1B#, 5) ELSE
      crcCheckSum_28 WHEN counter_opcrc_unsigned = to_unsigned(16#1C#, 5) ELSE
      crcCheckSum_29 WHEN counter_opcrc_unsigned = to_unsigned(16#1D#, 5) ELSE
      crcCheckSum_30 WHEN counter_opcrc_unsigned = to_unsigned(16#1E#, 5) ELSE
      crcCheckSum_31;

  
  msgcrc <= dataBuffer WHEN outputCRC = '0' ELSE
      crcOut;

  -- Output data and CRC CheckSum
  
  tdataout <= const0 WHEN validdata = '0' ELSE
      msgcrc;

  -- Data output register
  dataOut_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataOut <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        dataOut <= tdataout;
      END IF;
    END IF;
  END PROCESS dataOut_register_process;


  -- startOut output register
  startOut_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      startOut <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        startOut <= tstartout;
      END IF;
    END IF;
  END PROCESS startOut_register_process;


  -- endOut output register
  endout_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      endOut <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        endOut <= lastfout;
      END IF;
    END IF;
  END PROCESS endout_register_process;


  -- validOut output register
  validout_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      validOut <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        validOut <= validdata;
      END IF;
    END IF;
  END PROCESS validout_register_process;


END rtl;

