-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_Payload.vhd
-- Created: 2018-02-01 13:20:10
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Payload
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Transmitter HDL/Packet Generation/Payload
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_Payload IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        data                              :   IN    std_logic;
        start                             :   IN    std_logic;
        done                              :   IN    std_logic;
        mode                              :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        bits                              :   OUT   std_logic_vector(0 TO 1);  -- boolean [2]
        end_rsvd                          :   OUT   std_logic;
        valid                             :   OUT   std_logic
        );
END CombinedT_ip_src_Payload;


ARCHITECTURE rtl OF CombinedT_ip_src_Payload IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_Subsystem
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          In1                             :   IN    std_logic;
          In2                             :   IN    std_logic;
          Out1                            :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_General_CRC_Generator_HDL_Optimized
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          dataIn                          :   IN    std_logic;
          startIn                         :   IN    std_logic;
          endIn                           :   IN    std_logic;
          validIn                         :   IN    std_logic;
          dataOut                         :   OUT   std_logic;
          startOut                        :   OUT   std_logic;
          endOut                          :   OUT   std_logic;
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_MATLAB_Function_block3
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          enable                          :   IN    std_logic;
          reset_1                         :   OUT   std_logic;
          mode                            :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Convolutional_Encoder
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          Convolutional_Encoder_in        :   IN    std_logic;
          Convolutional_Encoder_reset     :   IN    std_logic;
          Convolutional_Encoder_out       :   OUT   std_logic_vector(0 TO 1)  -- boolean [2]
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_HDL_Scrambler_2_bits
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          bitsIn                          :   IN    std_logic_vector(0 TO 1);  -- boolean [2]
          reset_1                         :   IN    std_logic;
          bitsOut                         :   OUT   std_logic_vector(0 TO 1)  -- boolean [2]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_Subsystem
    USE ENTITY work.CombinedT_ip_src_Subsystem(rtl);

  FOR ALL : CombinedT_ip_src_General_CRC_Generator_HDL_Optimized
    USE ENTITY work.CombinedT_ip_src_General_CRC_Generator_HDL_Optimized(rtl);

  FOR ALL : CombinedT_ip_src_MATLAB_Function_block3
    USE ENTITY work.CombinedT_ip_src_MATLAB_Function_block3(rtl);

  FOR ALL : CombinedT_ip_src_Convolutional_Encoder
    USE ENTITY work.CombinedT_ip_src_Convolutional_Encoder(rtl);

  FOR ALL : CombinedT_ip_src_HDL_Scrambler_2_bits
    USE ENTITY work.CombinedT_ip_src_HDL_Scrambler_2_bits(rtl);

  -- Constants
  CONSTANT C_PNGEN_REG_INIT_VAL           : unsigned(9 DOWNTO 0) := 
    "0010010011";  -- ufix10

  -- Signals
  SIGNAL Subsystem_out1                   : std_logic;
  SIGNAL General_CRC_Generator_HDL_Optimized_out1 : std_logic;
  SIGNAL General_CRC_Generator_HDL_Optimized_out2 : std_logic;
  SIGNAL General_CRC_Generator_HDL_Optimized_out3 : std_logic;
  SIGNAL General_CRC_Generator_HDL_Optimized_out4 : std_logic;
  SIGNAL Compensate_For_Data_out1         : std_logic;
  SIGNAL Compensate_For_Data2_out1        : std_logic;
  SIGNAL reset_1                          : std_logic;
  SIGNAL mode_1                           : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL mode_unsigned                    : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL Allow_Reset_out1                 : std_logic;
  SIGNAL Random_Data_Gen1_out1            : std_logic;  -- ufix1
  SIGNAL Switch_out1                      : std_logic;
  SIGNAL Convolutional_Encoder_out1       : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Allow_Reset_of_Encoder_out1      : std_logic;
  SIGNAL HDL_Scrambler_2_bits_out1        : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Need_For_Extra_traceback_reg     : std_logic_vector(0 TO 67);  -- ufix1 [68]
  SIGNAL Need_For_Extra_traceback_out1    : std_logic;
  SIGNAL Compensate_For_Data1_out1        : std_logic;
  SIGNAL pn_reg                           : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL pn_out                           : std_logic;
  SIGNAL pn_xorout                        : std_logic;
  SIGNAL pn_newvalue                      : vector_of_unsigned10(0 TO 1);  -- ufix10 [2]
  SIGNAL pn_value_shifted                 : unsigned(8 DOWNTO 0);  -- ufix9_E1

BEGIN
  u_Subsystem : CombinedT_ip_src_Subsystem
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              In1 => start,
              In2 => done,
              Out1 => Subsystem_out1
              );

  u_General_CRC_Generator_HDL_Optimized : CombinedT_ip_src_General_CRC_Generator_HDL_Optimized
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              dataIn => data,
              startIn => start,
              endIn => done,
              validIn => Subsystem_out1,
              dataOut => General_CRC_Generator_HDL_Optimized_out1,
              startOut => General_CRC_Generator_HDL_Optimized_out2,
              endOut => General_CRC_Generator_HDL_Optimized_out3,
              validOut => General_CRC_Generator_HDL_Optimized_out4
              );

  u_MATLAB_Function : CombinedT_ip_src_MATLAB_Function_block3
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              enable => Compensate_For_Data2_out1,
              reset_1 => reset_1,
              mode => mode_1  -- uint8
              );

  u_Convolutional_Encoder : CombinedT_ip_src_Convolutional_Encoder
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              Convolutional_Encoder_in => Switch_out1,
              Convolutional_Encoder_reset => General_CRC_Generator_HDL_Optimized_out2,
              Convolutional_Encoder_out => Convolutional_Encoder_out1  -- boolean [2]
              );

  u_HDL_Scrambler_2_bits : CombinedT_ip_src_HDL_Scrambler_2_bits
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              bitsIn => Convolutional_Encoder_out1,  -- boolean [2]
              reset_1 => Allow_Reset_of_Encoder_out1,
              bitsOut => HDL_Scrambler_2_bits_out1  -- boolean [2]
              );

  Compensate_For_Data_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Compensate_For_Data_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Compensate_For_Data_out1 <= General_CRC_Generator_HDL_Optimized_out3;
      END IF;
    END IF;
  END PROCESS Compensate_For_Data_process;


  Compensate_For_Data2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Compensate_For_Data2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Compensate_For_Data2_out1 <= Compensate_For_Data_out1;
      END IF;
    END IF;
  END PROCESS Compensate_For_Data2_process;


  mode_unsigned <= unsigned(mode_1);

  
  switch_compare_1 <= '1' WHEN mode_unsigned > to_unsigned(16#00#, 8) ELSE
      '0';

  Allow_Reset_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Allow_Reset_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Allow_Reset_out1 <= General_CRC_Generator_HDL_Optimized_out1;
      END IF;
    END IF;
  END PROCESS Allow_Reset_process;


  pn_newvalue(0) <= C_PNGEN_REG_INIT_VAL WHEN ( reset_1 = '1' ) ELSE
                    pn_reg;

  pn_xorout <= pn_newvalue(0)(0) XOR pn_newvalue(0)(7);

  pn_value_shifted <= pn_newvalue(0)(9 DOWNTO 1);

  pn_newvalue(1) <= pn_xorout & pn_value_shifted;

  pn_out <= pn_newvalue(0)(0);

  PN_generation_temp_process2 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      pn_reg <= to_unsigned(147, 10);
    ELSIF clk'event AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        pn_reg <= pn_newvalue(1);
      END IF;
    END IF; 
  END PROCESS PN_generation_temp_process2;

  Random_Data_Gen1_out1 <= pn_out;


  
  Switch_out1 <= Allow_Reset_out1 WHEN switch_compare_1 = '0' ELSE
      Random_Data_Gen1_out1;

  Allow_Reset_of_Encoder_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Allow_Reset_of_Encoder_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Allow_Reset_of_Encoder_out1 <= General_CRC_Generator_HDL_Optimized_out2;
      END IF;
    END IF;
  END PROCESS Allow_Reset_of_Encoder_process;


  Need_For_Extra_traceback_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Need_For_Extra_traceback_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Need_For_Extra_traceback_reg(0) <= Compensate_For_Data_out1;
        Need_For_Extra_traceback_reg(1 TO 67) <= Need_For_Extra_traceback_reg(0 TO 66);
      END IF;
    END IF;
  END PROCESS Need_For_Extra_traceback_process;

  Need_For_Extra_traceback_out1 <= Need_For_Extra_traceback_reg(67);

  Compensate_For_Data1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Compensate_For_Data1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Compensate_For_Data1_out1 <= General_CRC_Generator_HDL_Optimized_out4;
      END IF;
    END IF;
  END PROCESS Compensate_For_Data1_process;



  bits <= HDL_Scrambler_2_bits_out1;

  end_rsvd <= Need_For_Extra_traceback_out1;

  valid <= Compensate_For_Data1_out1;

END rtl;

