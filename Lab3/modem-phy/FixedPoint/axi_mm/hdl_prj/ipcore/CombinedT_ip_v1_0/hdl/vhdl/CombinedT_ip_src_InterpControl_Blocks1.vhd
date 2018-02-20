-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_InterpControl_Blocks1.vhd
-- Created: 2018-02-01 18:12:06
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_InterpControl_Blocks1
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Frame Recover/Gardner Timing Recovery/InterpControl_Blocks1
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_InterpControl_Blocks1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        e                                 :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En24
        Enable_out2                       :   IN    std_logic;
        strobe                            :   OUT   std_logic;
        mu                                :   OUT   std_logic_vector(14 DOWNTO 0)  -- ufix15_En14
        );
END CombinedT_ip_src_InterpControl_Blocks1;


ARCHITECTURE rtl OF CombinedT_ip_src_InterpControl_Blocks1 IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_Mod_1
    PORT( In1                             :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          Out1                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- ufix16_En16
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Calculate_New_mu
    PORT( W                               :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          NCOCounter                      :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          mu                              :   OUT   std_logic_vector(14 DOWNTO 0)  -- ufix15_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_Mod_1
    USE ENTITY work.CombinedT_ip_src_Mod_1(rtl);

  FOR ALL : CombinedT_ip_src_Calculate_New_mu
    USE ENTITY work.CombinedT_ip_src_Calculate_New_mu(rtl);

  -- Signals
  SIGNAL e_signed                         : signed(15 DOWNTO 0);  -- sfix16_En24
  SIGNAL alpha1_SPS1_out1                 : unsigned(1 DOWNTO 0);  -- ufix2_En2
  SIGNAL Add1_add_cast                    : signed(24 DOWNTO 0);  -- sfix25_En24
  SIGNAL Add1_add_cast_1                  : signed(24 DOWNTO 0);  -- sfix25_En24
  SIGNAL Add1_add_temp                    : signed(24 DOWNTO 0);  -- sfix25_En24
  SIGNAL Add1_out1                        : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL enb_gated                        : std_logic;
  SIGNAL NCOCounter_State_out1            : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Subtract1_sub_cast               : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL Subtract1_sub_cast_1             : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL Subtract1_sub_temp               : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL Subtract1_out1                   : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Mod_1_out1                       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Mod_1_out1_unsigned              : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL strobe_W_NCOCounter_relop1       : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL enb_gated_1                      : std_logic;
  SIGNAL Calculate_New_mu_out1            : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL Calculate_New_mu_out1_unsigned   : unsigned(14 DOWNTO 0);  -- ufix15_En14
  SIGNAL Update_mu_on_strobe_out1         : unsigned(14 DOWNTO 0);  -- ufix15_En14
  SIGNAL saved_mu_out1                    : unsigned(14 DOWNTO 0);  -- ufix15_En14

BEGIN
  -- e<<1/SPS
  -- 
  -- Mu is always positive

  u_Mod_1 : CombinedT_ip_src_Mod_1
    PORT MAP( In1 => std_logic_vector(Subtract1_out1),  -- ufix16_En16
              Out1 => Mod_1_out1  -- ufix16_En16
              );

  u_Calculate_New_mu : CombinedT_ip_src_Calculate_New_mu
    PORT MAP( W => std_logic_vector(Add1_out1),  -- ufix16_En16
              NCOCounter => std_logic_vector(NCOCounter_State_out1),  -- ufix16_En16
              mu => Calculate_New_mu_out1  -- ufix15_En14
              );

  e_signed <= signed(e);

  alpha1_SPS1_out1 <= to_unsigned(16#1#, 2);

  Add1_add_cast <= resize(e_signed, 25);
  Add1_add_cast_1 <= signed(resize(alpha1_SPS1_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 25));
  Add1_add_temp <= Add1_add_cast + Add1_add_cast_1;
  Add1_out1 <= unsigned(Add1_add_temp(23 DOWNTO 8));

  enb_gated <= Enable_out2 AND enb;

  Subtract1_sub_cast <= signed(resize(NCOCounter_State_out1, 17));
  Subtract1_sub_cast_1 <= signed(resize(Add1_out1, 17));
  Subtract1_sub_temp <= Subtract1_sub_cast - Subtract1_sub_cast_1;
  Subtract1_out1 <= unsigned(Subtract1_sub_temp(15 DOWNTO 0));

  Mod_1_out1_unsigned <= unsigned(Mod_1_out1);

  NCOCounter_State_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      NCOCounter_State_out1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated = '1' THEN
        NCOCounter_State_out1 <= Mod_1_out1_unsigned;
      END IF;
    END IF;
  END PROCESS NCOCounter_State_process;


  
  strobe_W_NCOCounter_relop1 <= '1' WHEN Add1_out1 > NCOCounter_State_out1 ELSE
      '0';

  
  switch_compare_1 <= '1' WHEN strobe_W_NCOCounter_relop1 > '0' ELSE
      '0';

  enb_gated_1 <= Enable_out2 AND enb;

  Calculate_New_mu_out1_unsigned <= unsigned(Calculate_New_mu_out1);

  saved_mu_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      saved_mu_out1 <= to_unsigned(16#0000#, 15);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated_1 = '1' THEN
        saved_mu_out1 <= Update_mu_on_strobe_out1;
      END IF;
    END IF;
  END PROCESS saved_mu_process;


  
  Update_mu_on_strobe_out1 <= saved_mu_out1 WHEN switch_compare_1 = '0' ELSE
      Calculate_New_mu_out1_unsigned;

  mu <= std_logic_vector(Update_mu_on_strobe_out1);





  strobe <= strobe_W_NCOCounter_relop1;

END rtl;

