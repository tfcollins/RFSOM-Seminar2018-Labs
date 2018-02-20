-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_Find_Max_and_Set_Output_Shift.vhd
-- Created: 2018-02-01 18:12:05
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Find_Max_and_Set_Output_Shift
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Frame Recover/Barker Locate/Measure Phase Ambiguity/Find 
-- Max and Set Output Shif
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_Find_Max_and_Set_Output_Shift IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1_re                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In1_im                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In2_re                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In2_im                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In4_re                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In4_im                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In5_re                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        In5_im                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        Enable                            :   IN    std_logic;
        Out1_re                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        Out1_im                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En13
        );
END CombinedT_ip_src_Find_Max_and_Set_Output_Shift;


ARCHITECTURE rtl OF CombinedT_ip_src_Find_Max_and_Set_Output_Shift IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_Maximum
    PORT( in0                             :   IN    vector_of_std_logic_vector16(0 TO 3);  -- int16 [4]
          out0                            :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_Maximum
    USE ENTITY work.CombinedT_ip_src_Maximum(rtl);

  -- Constants
  CONSTANT Direct_Lookup_Table_n_D_table_data_re : vector_of_signed16(0 TO 3) := 
    (to_signed(16#2000#, 16), to_signed(16#0000#, 16), to_signed(-16#2000#, 16), to_signed(16#0000#, 16));  -- sfix16 [4]
  CONSTANT Direct_Lookup_Table_n_D_table_data_im : vector_of_signed16(0 TO 3) := 
    (to_signed(16#0000#, 16), to_signed(-16#2000#, 16), to_signed(16#0000#, 16), to_signed(16#2000#, 16));  -- sfix16 [4]

  -- Signals
  SIGNAL Enable_out5                      : std_logic;
  SIGNAL Vector_Concatenate_out1          : vector_of_std_logic_vector16(0 TO 3);  -- ufix16 [4]
  SIGNAL Maximum_out1                     : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Maximum_out1_unsigned            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Direct_Lookup_Table_n_D_out1_re  : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_im  : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_re_1 : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_im_1 : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16_En13
  SIGNAL delayMatch_reg_re                : vector_of_signed16(0 TO 2);  -- sfix16_En13 [3]
  SIGNAL delayMatch_reg_im                : vector_of_signed16(0 TO 2);  -- sfix16_En13 [3]
  SIGNAL Direct_Lookup_Table_n_D_out1_re_2 : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_im_2 : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_bypass_re : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_bypass_im : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_last_value_re : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Direct_Lookup_Table_n_D_out1_last_value_im : signed(15 DOWNTO 0);  -- sfix16_En13

BEGIN
  u_combinedTxRx_AXIMM_Combined_TX_and_RX_Receiver_HDL_Frame_Recover_Barker_Locate_Measure_Phase_Ambiguity_Find_Max_and_Set_Output_Shift_Maximum : CombinedT_ip_src_Maximum
    PORT MAP( in0 => Vector_Concatenate_out1,  -- int16 [4]
              out0 => Maximum_out1  -- uint32
              );

  Enable_out5 <= Enable;

  Vector_Concatenate_out1(0) <= In1_im;
  Vector_Concatenate_out1(1) <= In2_im;
  Vector_Concatenate_out1(2) <= In4_im;
  Vector_Concatenate_out1(3) <= In5_im;

  Maximum_out1_unsigned <= unsigned(Maximum_out1);

  Direct_Lookup_Table_n_D_out1_re <= Direct_Lookup_Table_n_D_table_data_re(to_integer(Maximum_out1_unsigned));
  Direct_Lookup_Table_n_D_out1_im <= Direct_Lookup_Table_n_D_table_data_im(to_integer(Maximum_out1_unsigned));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Direct_Lookup_Table_n_D_out1_re_1 <= Direct_Lookup_Table_n_D_out1_re;
        Direct_Lookup_Table_n_D_out1_im_1 <= Direct_Lookup_Table_n_D_out1_im;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      delayMatch_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg_im(0) <= Direct_Lookup_Table_n_D_out1_im_1;
        delayMatch_reg_im(1 TO 2) <= delayMatch_reg_im(0 TO 1);
        delayMatch_reg_re(0) <= Direct_Lookup_Table_n_D_out1_re_1;
        delayMatch_reg_re(1 TO 2) <= delayMatch_reg_re(0 TO 1);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  Direct_Lookup_Table_n_D_out1_re_2 <= delayMatch_reg_re(2);
  Direct_Lookup_Table_n_D_out1_im_2 <= delayMatch_reg_im(2);

  Out1_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Direct_Lookup_Table_n_D_out1_last_value_re <= to_signed(16#0000#, 16);
      Direct_Lookup_Table_n_D_out1_last_value_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Direct_Lookup_Table_n_D_out1_last_value_re <= Direct_Lookup_Table_n_D_out1_bypass_re;
        Direct_Lookup_Table_n_D_out1_last_value_im <= Direct_Lookup_Table_n_D_out1_bypass_im;
      END IF;
    END IF;
  END PROCESS Out1_bypass_process;


  
  Direct_Lookup_Table_n_D_out1_bypass_re <= Direct_Lookup_Table_n_D_out1_last_value_re WHEN Enable_out5 = '0' ELSE
      Direct_Lookup_Table_n_D_out1_re_2;
  
  Direct_Lookup_Table_n_D_out1_bypass_im <= Direct_Lookup_Table_n_D_out1_last_value_im WHEN Enable_out5 = '0' ELSE
      Direct_Lookup_Table_n_D_out1_im_2;

  Out1_re <= std_logic_vector(Direct_Lookup_Table_n_D_out1_bypass_re);

  Out1_im <= std_logic_vector(Direct_Lookup_Table_n_D_out1_bypass_im);



END rtl;

