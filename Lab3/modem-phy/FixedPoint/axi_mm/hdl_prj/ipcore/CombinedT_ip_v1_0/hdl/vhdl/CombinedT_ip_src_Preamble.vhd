-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_Preamble.vhd
-- Created: 2018-02-01 18:12:06
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Preamble
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/Packet Generation/Preamble
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_Preamble IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        enb_1_4_1                         :   IN    std_logic;
        reset_1                           :   IN    std_logic;
        Out1                              :   OUT   std_logic_vector(0 TO 1)  -- boolean [2]
        );
END CombinedT_ip_src_Preamble;


ARCHITECTURE rtl OF CombinedT_ip_src_Preamble IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_Unpack1
    PORT( In1                             :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          Out1                            :   OUT   std_logic_vector(0 TO 1)  -- boolean [2]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_Unpack1
    USE ENTITY work.CombinedT_ip_src_Unpack1(rtl);

  -- Constants
  CONSTANT nc                             : std_logic_vector(0 TO 586) := 
    ('0', '0', '0', '0', '1', '1', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1',
     '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '0', '1', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '1', '1', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0',
     '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '0', '1', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '1', '1', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '0',
     '1', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '0', '1', '1', '0', '1', '0', '0', '0', '1', '1', '1',
     '0', '1', '1', '0', '1', '0', '0', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
     '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');  -- ufix1 [587]
  CONSTANT C_PNGEN_REG_INIT_VAL           : unsigned(4 DOWNTO 0) := 
    "11100";  -- ufix5

  -- Signals
  SIGNAL HDL_Counter_out1                 : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Delay_out1                       : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Enable_at_end_of_barker_out1     : std_logic;
  SIGNAL Enable_at_end_of_barker_out1_1   : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL Reset_When_Barkers_Are_Done_out1 : std_logic;
  SIGNAL PN_Sequence_For_EQ_out1          : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Unpack1_out1                     : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Unpack1_out1_1                   : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Delay_out1_1                     : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Barker_Odd_out1                  : std_logic;
  SIGNAL Barker_Odd_out1_1                : std_logic := '0';
  SIGNAL Barker_Even_out1                 : std_logic;
  SIGNAL Barker_Even_out1_1               : std_logic := '0';
  SIGNAL Vector_Concatenate1_out1         : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Delay1_bypass_reg                : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Vector_Concatenate1_out1_1       : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Switch1_out1                     : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL pn_reg                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL pn_out                           : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL pn_xorout                        : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL pn_newvalue                      : vector_of_unsigned5(0 TO 2);  -- ufix5 [3]
  SIGNAL pn_value_shifted                 : vector_of_unsigned4(0 TO 1);  -- ufix4_E1 [2]

BEGIN
  u_Unpack1 : CombinedT_ip_src_Unpack1
    PORT MAP( In1 => std_logic_vector(PN_Sequence_For_EQ_out1),  -- ufix2
              Out1 => Unpack1_out1  -- boolean [2]
              );

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 586
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        IF reset_1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(16#0000#, 16);
        ELSIF HDL_Counter_out1 >= to_unsigned(16#024A#, 16) THEN 
          HDL_Counter_out1 <= to_unsigned(16#0000#, 16);
        ELSE 
          HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#0001#, 16);
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Delay_out1 <= HDL_Counter_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  
  Enable_at_end_of_barker_out1 <= '1' WHEN Delay_out1 < to_unsigned(16#00BB#, 16) ELSE
      '0';

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Enable_at_end_of_barker_out1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Enable_at_end_of_barker_out1_1 <= Enable_at_end_of_barker_out1;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  
  switch_compare_1 <= '1' WHEN Enable_at_end_of_barker_out1_1 = '1' ELSE
      '0';

  
  Reset_When_Barkers_Are_Done_out1 <= '1' WHEN Delay_out1 = to_unsigned(16#00BB#, 16) ELSE
      '0';

  pn_newvalue(0) <= C_PNGEN_REG_INIT_VAL WHEN ( Reset_When_Barkers_Are_Done_out1 = '1' ) ELSE
                    pn_reg;

--**stage 1
  pn_xorout(0) <= pn_newvalue(0)(0) XOR pn_newvalue(0)(1) XOR pn_newvalue(0)(3);

  pn_value_shifted(0) <= pn_newvalue(0)(4 DOWNTO 1);

  pn_newvalue(1) <= pn_xorout(0) & pn_value_shifted(0);

  pn_out(1) <= pn_newvalue(0)(0);

--**stage 2
  pn_xorout(1) <= pn_newvalue(1)(0) XOR pn_newvalue(1)(1) XOR pn_newvalue(1)(3);

  pn_value_shifted(1) <= pn_newvalue(1)(4 DOWNTO 1);

  pn_newvalue(2) <= pn_xorout(1) & pn_value_shifted(1);

  pn_out(0) <= pn_newvalue(1)(0);

  PN_generation_temp_process3 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      pn_reg <= to_unsigned(28, 5);
    ELSIF clk'event AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        pn_reg <= pn_newvalue(2);
      END IF;
    END IF; 
  END PROCESS PN_generation_temp_process3;

  PN_Sequence_For_EQ_out1 <= pn_out;


  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unpack1_out1_1 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        Unpack1_out1_1 <= Unpack1_out1;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  Delay_out1_1 <= Delay_out1;

  Barker_Odd_out1 <= nc(to_integer(Delay_out1_1));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Barker_Odd_out1_1 <= Barker_Odd_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Barker_Even_out1 <= '0';

  PipelineRegister1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Barker_Even_out1_1 <= Barker_Even_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Vector_Concatenate1_out1(0) <= Barker_Odd_out1_1;
  Vector_Concatenate1_out1(1) <= Barker_Even_out1_1;

  Delay1_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_bypass_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_1 = '1' THEN
        Delay1_bypass_reg <= Vector_Concatenate1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_bypass_process;

  
  Vector_Concatenate1_out1_1 <= Vector_Concatenate1_out1 WHEN enb_1_4_1 = '1' ELSE
      Delay1_bypass_reg;

  
  Switch1_out1 <= Unpack1_out1_1 WHEN switch_compare_1 = '0' ELSE
      Vector_Concatenate1_out1_1;

  Out1 <= Switch1_out1;

END rtl;

