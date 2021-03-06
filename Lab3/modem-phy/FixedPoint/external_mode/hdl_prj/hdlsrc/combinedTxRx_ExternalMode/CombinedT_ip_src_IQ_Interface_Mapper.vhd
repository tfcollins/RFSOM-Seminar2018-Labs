-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_IQ_Interface_Mapper.vhd
-- Created: 2018-02-01 13:20:08
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_IQ_Interface_Mapper
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/IQ Interface Mapper
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_IQ_Interface_Mapper IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        byteOut                           :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        validOut                          :   IN    std_logic;
        startOut                          :   IN    std_logic;
        packetLenOut                      :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        SelectorR                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        SelectorI                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        signal2                           :   IN    std_logic;
        err                               :   IN    std_logic;
        valid                             :   IN    std_logic;
        end_rsvd                          :   IN    std_logic;
        In11                              :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        real_rsvd                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        imag                              :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        valid_1                           :   OUT   std_logic;
        Out3                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
        );
END CombinedT_ip_src_IQ_Interface_Mapper;


ARCHITECTURE rtl OF CombinedT_ip_src_IQ_Interface_Mapper IS

  -- Signals
  SIGNAL In2                              : std_logic;
  SIGNAL In3                              : std_logic;
  SIGNAL In8                              : std_logic;
  SIGNAL In9                              : std_logic;
  SIGNAL In10                             : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL Delay2_reg                       : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Delay_reg                        : vector_of_unsigned32(0 TO 1);  -- ufix32 [2]
  SIGNAL Delay_out1                       : unsigned(31 DOWNTO 0);  -- uint32

BEGIN
  In2 <= validOut;

  In3 <= startOut;

  In8 <= err;

  In9 <= valid;

  In10 <= end_rsvd;

  Logical_Operator_out1 <= In9 AND In10;

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_reg(0) <= Logical_Operator_out1;
        Delay2_reg(1) <= Delay2_reg(0);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1 <= Delay2_reg(1);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 4294967295
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND Delay2_out1 = '1' THEN
        HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(1, 32);
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg <= (OTHERS => to_unsigned(0, 32));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_reg(0) <= HDL_Counter_out1;
        Delay_reg(1) <= Delay_reg(0);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1 <= Delay_reg(1);

  Out3 <= std_logic_vector(Delay_out1);












  real_rsvd <= SelectorR;

  imag <= SelectorI;

  valid_1 <= signal2;

END rtl;

