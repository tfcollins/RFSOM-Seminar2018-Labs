-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_StandardIQ\CombinedT_ip_src_Buffer.vhd
-- Created: 2018-02-01 11:49:53
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Buffer
-- Source Path: combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Viterbi Decode/Buffer
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Buffer IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        data                              :   IN    std_logic_vector(0 TO 1);  -- boolean [2]
        start                             :   IN    std_logic;
        valid                             :   IN    std_logic;
        crc                               :   IN    std_logic;
        packetLen                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        dataOut                           :   OUT   std_logic_vector(0 TO 1);  -- boolean [2]
        resetOut                          :   OUT   std_logic;
        validOut                          :   OUT   std_logic;
        crcOut                            :   OUT   std_logic;
        packetLenOut                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- uint16
        );
END CombinedT_ip_src_Buffer;


ARCHITECTURE rtl OF CombinedT_ip_src_Buffer IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_MATLAB_Function_block2
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          valid                           :   IN    std_logic;
          start                           :   IN    std_logic;
          crcEnd                          :   IN    std_logic;
          enable                          :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_MATLAB_Function1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          packetLen                       :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          valid                           :   IN    std_logic;
          crcStart                        :   IN    std_logic;
          enablePop                       :   OUT   std_logic;
          validOut                        :   OUT   std_logic;
          viterbiReset                    :   OUT   std_logic;
          crcOut                          :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_HDL_FIFO
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In_rsvd                         :   IN    std_logic;
          Push                            :   IN    std_logic;
          Pop                             :   IN    std_logic;
          Out_rsvd                        :   OUT   std_logic;
          Num                             :   OUT   std_logic_vector(16 DOWNTO 0)  -- ufix17
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_HDL_FIFO1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In_rsvd                         :   IN    std_logic;
          Push                            :   IN    std_logic;
          Pop                             :   IN    std_logic;
          Out_rsvd                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_HDL_FIFO2
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In_rsvd                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          Push                            :   IN    std_logic;
          Pop                             :   IN    std_logic;
          Out_rsvd                        :   OUT   std_logic_vector(15 DOWNTO 0)  -- uint16
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_MATLAB_Function_block2
    USE ENTITY work.CombinedT_ip_src_MATLAB_Function_block2(rtl);

  FOR ALL : CombinedT_ip_src_MATLAB_Function1
    USE ENTITY work.CombinedT_ip_src_MATLAB_Function1(rtl);

  FOR ALL : CombinedT_ip_src_HDL_FIFO
    USE ENTITY work.CombinedT_ip_src_HDL_FIFO(rtl);

  FOR ALL : CombinedT_ip_src_HDL_FIFO1
    USE ENTITY work.CombinedT_ip_src_HDL_FIFO1(rtl);

  FOR ALL : CombinedT_ip_src_HDL_FIFO2
    USE ENTITY work.CombinedT_ip_src_HDL_FIFO2(rtl);

  -- Signals
  SIGNAL Delay_To_Trackback_Length_reg    : std_logic_vector(0 TO 135);  -- ufix1 [136]
  SIGNAL Delay_To_Trackback_Length_out1   : std_logic;
  SIGNAL enable                           : std_logic;
  SIGNAL packetLen_unsigned               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Delay2_out1                      : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL enablePop                        : std_logic;
  SIGNAL validOut_1                       : std_logic;
  SIGNAL viterbiReset                     : std_logic;
  SIGNAL HDL_FIFO_out2                    : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Mux_out1                         : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Allow_Viterbi_Reset1_out1        : std_logic;
  SIGNAL HDL_FIFO2_out1                   : std_logic_vector(15 DOWNTO 0);  -- ufix16

BEGIN
  u_MATLAB_Function : CombinedT_ip_src_MATLAB_Function_block2
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              valid => valid,
              start => start,
              crcEnd => Delay_To_Trackback_Length_out1,
              enable => enable
              );

  u_MATLAB_Function1 : CombinedT_ip_src_MATLAB_Function1
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              packetLen => std_logic_vector(Delay2_out1),  -- uint16
              valid => Delay_out1,
              crcStart => Delay1_out1,
              enablePop => enablePop,
              validOut => validOut_1,
              viterbiReset => viterbiReset,
              crcOut => crcOut
              );

  u_HDL_FIFO : CombinedT_ip_src_HDL_FIFO
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In_rsvd => data(0),
              Push => enable,
              Pop => enablePop,
              Out_rsvd => Mux_out1(0),
              Num => HDL_FIFO_out2  -- ufix17
              );

  u_HDL_FIFO1 : CombinedT_ip_src_HDL_FIFO1
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In_rsvd => data(1),
              Push => enable,
              Pop => enablePop,
              Out_rsvd => Mux_out1(1)
              );

  u_HDL_FIFO2 : CombinedT_ip_src_HDL_FIFO2
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In_rsvd => packetLen,  -- uint16
              Push => start,
              Pop => Delay_To_Trackback_Length_out1,
              Out_rsvd => HDL_FIFO2_out1  -- uint16
              );

  Delay_To_Trackback_Length_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_To_Trackback_Length_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_To_Trackback_Length_reg(0) <= crc;
        Delay_To_Trackback_Length_reg(1 TO 135) <= Delay_To_Trackback_Length_reg(0 TO 134);
      END IF;
    END IF;
  END PROCESS Delay_To_Trackback_Length_process;

  Delay_To_Trackback_Length_out1 <= Delay_To_Trackback_Length_reg(135);

  packetLen_unsigned <= unsigned(packetLen);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= packetLen_unsigned;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= valid;
      END IF;
    END IF;
  END PROCESS Delay_process;


  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Delay_To_Trackback_Length_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;



  Allow_Viterbi_Reset1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Allow_Viterbi_Reset1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Allow_Viterbi_Reset1_out1 <= validOut_1;
      END IF;
    END IF;
  END PROCESS Allow_Viterbi_Reset1_process;



  dataOut <= Mux_out1;

  resetOut <= viterbiReset;

  validOut <= Allow_Viterbi_Reset1_out1;

  packetLenOut <= HDL_FIFO2_out1;

END rtl;

