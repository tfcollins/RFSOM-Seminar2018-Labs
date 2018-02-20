-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_Barker_Locate.vhd
-- Created: 2018-02-01 13:20:09
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Barker_Locate
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/Frame Recover/Barker Locate
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_Barker_Locate IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1_re                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        In1_im                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        validIn                           :   IN    std_logic;
        Detector                          :   OUT   std_logic;
        validOut                          :   OUT   std_logic;
        Signal_re                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        Signal_im                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END CombinedT_ip_src_Barker_Locate;


ARCHITECTURE rtl OF CombinedT_ip_src_Barker_Locate IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_HDL_Opt_Complex_FIR
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          validIn                         :   IN    std_logic;
          Out1_re                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          Out1_im                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_ABS1
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          Out1                            :   OUT   std_logic_vector(16 DOWNTO 0)  -- sfix17
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Discrete_FIR_Filter_HDL_Optimized_block4
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17
          validIn                         :   IN    std_logic;
          dataOut                         :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_ABS2
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          Out1                            :   OUT   std_logic_vector(16 DOWNTO 0)  -- sfix17
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Measure_Phase_Ambiguity
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          trigger                         :   IN    std_logic;
          validIn                         :   IN    std_logic;
          PA_re                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          PA_im                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En13
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_HDL_Opt_Complex_FIR
    USE ENTITY work.CombinedT_ip_src_HDL_Opt_Complex_FIR(rtl);

  FOR ALL : CombinedT_ip_src_ABS1
    USE ENTITY work.CombinedT_ip_src_ABS1(rtl);

  FOR ALL : CombinedT_ip_src_Discrete_FIR_Filter_HDL_Optimized_block4
    USE ENTITY work.CombinedT_ip_src_Discrete_FIR_Filter_HDL_Optimized_block4(rtl);

  FOR ALL : CombinedT_ip_src_ABS2
    USE ENTITY work.CombinedT_ip_src_ABS2(rtl);

  FOR ALL : CombinedT_ip_src_Measure_Phase_Ambiguity
    USE ENTITY work.CombinedT_ip_src_Measure_Phase_Ambiguity(rtl);

  -- Signals
  SIGNAL In1_re_signed                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL In1_im_signed                    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Force_Scaling_To_something_easy_out1_re : signed(15 DOWNTO 0);  -- int16
  SIGNAL Force_Scaling_To_something_easy_out1_im : signed(15 DOWNTO 0);  -- int16
  SIGNAL HDL_Opt_Complex_FIR_out1_re      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL HDL_Opt_Complex_FIR_out1_im      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL HDL_Opt_Complex_FIR_out2         : std_logic;
  SIGNAL ABS1_out1                        : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Discrete_FIR_Filter_HDL_Optimized_out1 : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL Discrete_FIR_Filter_HDL_Optimized_out2 : std_logic;
  SIGNAL ABS2_out1                        : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL ABS2_out1_signed                 : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Discrete_FIR_Filter_HDL_Optimized_out1_signed : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Reciprocal_out1                  : signed(16 DOWNTO 0);  -- sfix17_En15
  SIGNAL Normalize_mul_temp               : signed(33 DOWNTO 0);  -- sfix34_En15
  SIGNAL Normalize_out1                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL Delay_to_start_training_sample_out1 : std_logic;
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL Match_Above_Flag_Timing_out1     : std_logic;
  SIGNAL Measure_Phase_Ambiguity_out1_re  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Measure_Phase_Ambiguity_out1_im  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Measure_Phase_Ambiguity_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Measure_Phase_Ambiguity_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL HDL_FIR_Has_additional_Delay_reg_re : vector_of_signed16(0 TO 31);  -- sfix16_En13 [32]
  SIGNAL HDL_FIR_Has_additional_Delay_reg_im : vector_of_signed16(0 TO 31);  -- sfix16_En13 [32]
  SIGNAL HDL_FIR_Has_additional_Delay_out1_re : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL HDL_FIR_Has_additional_Delay_out1_im : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL HDL_FIR_Has_additional_Delay_out1_re_1 : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL HDL_FIR_Has_additional_Delay_out1_im_1 : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Phase_Ambiguity_Correct_mul_temp : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Phase_Ambiguity_Correct_sub_cast : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Phase_Ambiguity_Correct_mul_temp_1 : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Phase_Ambiguity_Correct_sub_cast_1 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Phase_Ambiguity_Correct_mul_temp_2 : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Phase_Ambiguity_Correct_add_cast : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Phase_Ambiguity_Correct_mul_temp_3 : signed(31 DOWNTO 0);  -- sfix32_En26
  SIGNAL Phase_Ambiguity_Correct_add_cast_1 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Phase_Ambiguity_Correct_out1_re  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Phase_Ambiguity_Correct_out1_im  : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  -- General Notes:This block needs some noise on the input since packet gaps (aka all zeros) will cause false peaks
  -- 
  -- Delay so at high detector we have start of preamble
  -- 
  -- Power Path
  -- 
  -- Signal Path

  u_HDL_Opt_Complex_FIR : CombinedT_ip_src_HDL_Opt_Complex_FIR
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In1_re => std_logic_vector(Force_Scaling_To_something_easy_out1_re),  -- int16
              In1_im => std_logic_vector(Force_Scaling_To_something_easy_out1_im),  -- int16
              validIn => validIn,
              Out1_re => HDL_Opt_Complex_FIR_out1_re,  -- int16
              Out1_im => HDL_Opt_Complex_FIR_out1_im,  -- int16
              validOut => HDL_Opt_Complex_FIR_out2
              );

  u_ABS1 : CombinedT_ip_src_ABS1
    PORT MAP( In1_re => std_logic_vector(Force_Scaling_To_something_easy_out1_re),  -- int16
              In1_im => std_logic_vector(Force_Scaling_To_something_easy_out1_im),  -- int16
              Out1 => ABS1_out1  -- sfix17
              );

  u_Discrete_FIR_Filter_HDL_Optimized : CombinedT_ip_src_Discrete_FIR_Filter_HDL_Optimized_block4
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn => ABS1_out1,  -- sfix17
              validIn => validIn,
              dataOut => Discrete_FIR_Filter_HDL_Optimized_out1,  -- sfix17
              validOut => Discrete_FIR_Filter_HDL_Optimized_out2
              );

  u_ABS2 : CombinedT_ip_src_ABS2
    PORT MAP( In1_re => HDL_Opt_Complex_FIR_out1_re,  -- int16
              In1_im => HDL_Opt_Complex_FIR_out1_im,  -- int16
              Out1 => ABS2_out1  -- sfix17
              );

  u_Measure_Phase_Ambiguity : CombinedT_ip_src_Measure_Phase_Ambiguity
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              data_re => std_logic_vector(Force_Scaling_To_something_easy_out1_re),  -- int16
              data_im => std_logic_vector(Force_Scaling_To_something_easy_out1_im),  -- int16
              trigger => Compare_To_Constant_out1,
              validIn => HDL_Opt_Complex_FIR_out2,
              PA_re => Measure_Phase_Ambiguity_out1_re,  -- sfix16_En13
              PA_im => Measure_Phase_Ambiguity_out1_im  -- sfix16_En13
              );

  In1_re_signed <= signed(In1_re);

  In1_im_signed <= signed(In1_im);

  Force_Scaling_To_something_easy_out1_re <= resize(In1_re_signed(15 DOWNTO 13), 16);
  Force_Scaling_To_something_easy_out1_im <= resize(In1_im_signed(15 DOWNTO 13), 16);

  ABS2_out1_signed <= signed(ABS2_out1);

  Discrete_FIR_Filter_HDL_Optimized_out1_signed <= signed(Discrete_FIR_Filter_HDL_Optimized_out1);

  Reciprocal_output : PROCESS (Discrete_FIR_Filter_HDL_Optimized_out1_signed)
    VARIABLE div_temp : signed(16 DOWNTO 0);
  BEGIN
    IF Discrete_FIR_Filter_HDL_Optimized_out1_signed = to_signed(16#00000#, 17) THEN 
      Reciprocal_out1 <= to_signed(16#0FFFF#, 17);
    ELSE 
      div_temp := to_signed(16#08000#, 17) / Discrete_FIR_Filter_HDL_Optimized_out1_signed;
      Reciprocal_out1 <= div_temp;
    END IF;
  END PROCESS Reciprocal_output;


  Normalize_mul_temp <= ABS2_out1_signed * Reciprocal_out1;
  
  Normalize_out1 <= X"7FFF" WHEN (Normalize_mul_temp(33) = '0') AND (Normalize_mul_temp(32 DOWNTO 30) /= "000") ELSE
      X"8000" WHEN (Normalize_mul_temp(33) = '1') AND (Normalize_mul_temp(32 DOWNTO 30) /= "111") ELSE
      Normalize_mul_temp(30 DOWNTO 15);

  
  Compare_To_Constant_out1 <= '1' WHEN Normalize_out1 >= to_signed(16#000E#, 16) ELSE
      '0';

  Logical_Operator_out1 <= Discrete_FIR_Filter_HDL_Optimized_out2 AND (Compare_To_Constant_out1 AND HDL_Opt_Complex_FIR_out2);

  Delay_to_start_training_sample_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_to_start_training_sample_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_to_start_training_sample_out1 <= Logical_Operator_out1;
      END IF;
    END IF;
  END PROCESS Delay_to_start_training_sample_process;


  Logical_Operator1_out1 <= HDL_Opt_Complex_FIR_out2 AND Discrete_FIR_Filter_HDL_Optimized_out2;

  Match_Above_Flag_Timing_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Match_Above_Flag_Timing_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Match_Above_Flag_Timing_out1 <= Logical_Operator1_out1;
      END IF;
    END IF;
  END PROCESS Match_Above_Flag_Timing_process;


  Measure_Phase_Ambiguity_out1_re_signed <= signed(Measure_Phase_Ambiguity_out1_re);

  Measure_Phase_Ambiguity_out1_im_signed <= signed(Measure_Phase_Ambiguity_out1_im);

  HDL_FIR_Has_additional_Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_FIR_Has_additional_Delay_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      HDL_FIR_Has_additional_Delay_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        HDL_FIR_Has_additional_Delay_reg_im(0) <= In1_im_signed;
        HDL_FIR_Has_additional_Delay_reg_im(1 TO 31) <= HDL_FIR_Has_additional_Delay_reg_im(0 TO 30);
        HDL_FIR_Has_additional_Delay_reg_re(0) <= In1_re_signed;
        HDL_FIR_Has_additional_Delay_reg_re(1 TO 31) <= HDL_FIR_Has_additional_Delay_reg_re(0 TO 30);
      END IF;
    END IF;
  END PROCESS HDL_FIR_Has_additional_Delay_process;

  HDL_FIR_Has_additional_Delay_out1_re <= HDL_FIR_Has_additional_Delay_reg_re(31);
  HDL_FIR_Has_additional_Delay_out1_im <= HDL_FIR_Has_additional_Delay_reg_im(31);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_FIR_Has_additional_Delay_out1_re_1 <= to_signed(16#0000#, 16);
      HDL_FIR_Has_additional_Delay_out1_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        HDL_FIR_Has_additional_Delay_out1_re_1 <= HDL_FIR_Has_additional_Delay_out1_re;
        HDL_FIR_Has_additional_Delay_out1_im_1 <= HDL_FIR_Has_additional_Delay_out1_im;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  Phase_Ambiguity_Correct_mul_temp <= Measure_Phase_Ambiguity_out1_re_signed * HDL_FIR_Has_additional_Delay_out1_re_1;
  Phase_Ambiguity_Correct_sub_cast <= Phase_Ambiguity_Correct_mul_temp(27 DOWNTO 12);
  Phase_Ambiguity_Correct_mul_temp_1 <= Measure_Phase_Ambiguity_out1_im_signed * HDL_FIR_Has_additional_Delay_out1_im_1;
  Phase_Ambiguity_Correct_sub_cast_1 <= Phase_Ambiguity_Correct_mul_temp_1(27 DOWNTO 12);
  Phase_Ambiguity_Correct_out1_re <= Phase_Ambiguity_Correct_sub_cast - Phase_Ambiguity_Correct_sub_cast_1;
  Phase_Ambiguity_Correct_mul_temp_2 <= Measure_Phase_Ambiguity_out1_im_signed * HDL_FIR_Has_additional_Delay_out1_re_1;
  Phase_Ambiguity_Correct_add_cast <= Phase_Ambiguity_Correct_mul_temp_2(27 DOWNTO 12);
  Phase_Ambiguity_Correct_mul_temp_3 <= Measure_Phase_Ambiguity_out1_re_signed * HDL_FIR_Has_additional_Delay_out1_im_1;
  Phase_Ambiguity_Correct_add_cast_1 <= Phase_Ambiguity_Correct_mul_temp_3(27 DOWNTO 12);
  Phase_Ambiguity_Correct_out1_im <= Phase_Ambiguity_Correct_add_cast + Phase_Ambiguity_Correct_add_cast_1;

  Signal_re <= std_logic_vector(Phase_Ambiguity_Correct_out1_re);

  Signal_im <= std_logic_vector(Phase_Ambiguity_Correct_out1_im);



  Detector <= Delay_to_start_training_sample_out1;

  validOut <= Match_Above_Flag_Timing_out1;

END rtl;

