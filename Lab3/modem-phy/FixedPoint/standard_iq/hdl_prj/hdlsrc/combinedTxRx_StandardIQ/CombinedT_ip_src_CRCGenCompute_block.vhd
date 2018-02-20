-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_StandardIQ\CombinedT_ip_src_CRCGenCompute_block.vhd
-- Created: 2018-02-01 11:49:53
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_CRCGenCompute_block
-- Source Path: combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/Packet Generation/Payload/General CRC 
-- Generator HDL Optimized/CRCGenComput
-- Hierarchy Level: 5
-- 
-- Compute the CRC CheckSum
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_CRCGenCompute_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        datainReg                         :   IN    std_logic;  -- ufix1
        validIn                           :   IN    std_logic;  -- ufix1
        processMsg                        :   IN    std_logic;  -- ufix1
        padZero                           :   IN    std_logic;  -- ufix1
        counter                           :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        crcChecksum                       :   OUT   std_logic_vector(0 TO 31)  -- ufix1 [32]
        );
END CombinedT_ip_src_CRCGenCompute_block;


ARCHITECTURE rtl OF CombinedT_ip_src_CRCGenCompute_block IS

  -- Signals
  SIGNAL counter_unsigned                 : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xoredSel                         : std_logic;  -- ufix1
  SIGNAL dvalidin                         : std_logic;  -- ufix1
  SIGNAL tcsSel                           : std_logic;  -- ufix1
  SIGNAL csSel                            : std_logic;  -- ufix1
  SIGNAL rpadZero                         : std_logic;  -- ufix1
  SIGNAL dataSel                          : std_logic;  -- ufix1
  SIGNAL padingzeros                      : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL inputzeros                       : std_logic_vector(0 TO 30);  -- ufix1 [31]
  SIGNAL datamux                          : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL datacpt                          : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL datacpt_31                       : std_logic;  -- ufix1
  SIGNAL datacpt_30                       : std_logic;  -- ufix1
  SIGNAL datacpt_29                       : std_logic;  -- ufix1
  SIGNAL datacpt_28                       : std_logic;  -- ufix1
  SIGNAL datacpt_27                       : std_logic;  -- ufix1
  SIGNAL datacpt_26                       : std_logic;  -- ufix1
  SIGNAL datacpt_25                       : std_logic;  -- ufix1
  SIGNAL datacpt_24                       : std_logic;  -- ufix1
  SIGNAL datacpt_23                       : std_logic;  -- ufix1
  SIGNAL datacpt_22                       : std_logic;  -- ufix1
  SIGNAL datacpt_21                       : std_logic;  -- ufix1
  SIGNAL datacpt_20                       : std_logic;  -- ufix1
  SIGNAL datacpt_19                       : std_logic;  -- ufix1
  SIGNAL datacpt_18                       : std_logic;  -- ufix1
  SIGNAL datacpt_17                       : std_logic;  -- ufix1
  SIGNAL datacpt_16                       : std_logic;  -- ufix1
  SIGNAL datacpt_15                       : std_logic;  -- ufix1
  SIGNAL datacpt_14                       : std_logic;  -- ufix1
  SIGNAL datacpt_13                       : std_logic;  -- ufix1
  SIGNAL datacpt_12                       : std_logic;  -- ufix1
  SIGNAL datacpt_11                       : std_logic;  -- ufix1
  SIGNAL datacpt_10                       : std_logic;  -- ufix1
  SIGNAL datacpt_9                        : std_logic;  -- ufix1
  SIGNAL datacpt_8                        : std_logic;  -- ufix1
  SIGNAL datacpt_7                        : std_logic;  -- ufix1
  SIGNAL datacpt_6                        : std_logic;  -- ufix1
  SIGNAL datacpt_5                        : std_logic;  -- ufix1
  SIGNAL datacpt_4                        : std_logic;  -- ufix1
  SIGNAL datacpt_3                        : std_logic;  -- ufix1
  SIGNAL datacpt_2                        : std_logic;  -- ufix1
  SIGNAL datacpt_1                        : std_logic;  -- ufix1
  SIGNAL datacpt_0                        : std_logic;  -- ufix1
  SIGNAL finalXorValue                    : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL finalXorValue_0                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_1                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_2                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_3                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_4                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_5                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_6                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_7                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_8                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_9                  : std_logic;  -- ufix1
  SIGNAL finalXorValue_10                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_11                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_12                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_13                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_14                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_15                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_16                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_17                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_18                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_19                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_20                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_21                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_22                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_23                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_24                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_25                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_26                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_27                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_28                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_29                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_30                 : std_logic;  -- ufix1
  SIGNAL finalXorValue_31                 : std_logic;  -- ufix1
  SIGNAL newChecksum                      : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL newChecksum_0                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_31               : std_logic;  -- ufix1
  SIGNAL newChecksum_1                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_30               : std_logic;  -- ufix1
  SIGNAL newChecksum_2                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_29               : std_logic;  -- ufix1
  SIGNAL newChecksum_3                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_28               : std_logic;  -- ufix1
  SIGNAL newChecksum_4                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_27               : std_logic;  -- ufix1
  SIGNAL newChecksum_5                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_26               : std_logic;  -- ufix1
  SIGNAL newChecksum_6                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_25               : std_logic;  -- ufix1
  SIGNAL newChecksum_7                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_24               : std_logic;  -- ufix1
  SIGNAL newChecksum_8                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_23               : std_logic;  -- ufix1
  SIGNAL newChecksum_9                    : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_22               : std_logic;  -- ufix1
  SIGNAL newChecksum_10                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_21               : std_logic;  -- ufix1
  SIGNAL newChecksum_11                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_20               : std_logic;  -- ufix1
  SIGNAL newChecksum_12                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_19               : std_logic;  -- ufix1
  SIGNAL newChecksum_13                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_18               : std_logic;  -- ufix1
  SIGNAL newChecksum_14                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_17               : std_logic;  -- ufix1
  SIGNAL newChecksum_15                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_16               : std_logic;  -- ufix1
  SIGNAL newChecksum_16                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_15               : std_logic;  -- ufix1
  SIGNAL newChecksum_17                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_14               : std_logic;  -- ufix1
  SIGNAL newChecksum_18                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_13               : std_logic;  -- ufix1
  SIGNAL newChecksum_19                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_12               : std_logic;  -- ufix1
  SIGNAL newChecksum_20                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_11               : std_logic;  -- ufix1
  SIGNAL newChecksum_21                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_10               : std_logic;  -- ufix1
  SIGNAL newChecksum_22                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_9                : std_logic;  -- ufix1
  SIGNAL newChecksum_23                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_8                : std_logic;  -- ufix1
  SIGNAL newChecksum_24                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_7                : std_logic;  -- ufix1
  SIGNAL newChecksum_25                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_6                : std_logic;  -- ufix1
  SIGNAL newChecksum_26                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_5                : std_logic;  -- ufix1
  SIGNAL newChecksum_27                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_4                : std_logic;  -- ufix1
  SIGNAL newChecksum_28                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_3                : std_logic;  -- ufix1
  SIGNAL newChecksum_29                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_2                : std_logic;  -- ufix1
  SIGNAL newChecksum_30                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_1                : std_logic;  -- ufix1
  SIGNAL newChecksum_31                   : std_logic;  -- ufix1
  SIGNAL refelctCheckSum_0                : std_logic;  -- ufix1
  SIGNAL xoredChecksum                    : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL checksumReg                      : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL checksumReg_30                   : std_logic;  -- ufix1
  SIGNAL tcs_entry31                      : std_logic;  -- ufix1
  SIGNAL checksumReg_29                   : std_logic;  -- ufix1
  SIGNAL tcs_entry30                      : std_logic;  -- ufix1
  SIGNAL checksumReg_28                   : std_logic;  -- ufix1
  SIGNAL tcs_entry29                      : std_logic;  -- ufix1
  SIGNAL checksumReg_27                   : std_logic;  -- ufix1
  SIGNAL tcs_entry28                      : std_logic;  -- ufix1
  SIGNAL checksumReg_26                   : std_logic;  -- ufix1
  SIGNAL tcs_entry27                      : std_logic;  -- ufix1
  SIGNAL checksumReg_25                   : std_logic;  -- ufix1
  SIGNAL checksumReg_31                   : std_logic;  -- ufix1
  SIGNAL tcs_entry26                      : std_logic;  -- ufix1
  SIGNAL checksumReg_24                   : std_logic;  -- ufix1
  SIGNAL tcs_entry25                      : std_logic;  -- ufix1
  SIGNAL checksumReg_23                   : std_logic;  -- ufix1
  SIGNAL tcs_entry24                      : std_logic;  -- ufix1
  SIGNAL checksumReg_22                   : std_logic;  -- ufix1
  SIGNAL tcs_entry23                      : std_logic;  -- ufix1
  SIGNAL checksumReg_21                   : std_logic;  -- ufix1
  SIGNAL tcs_entry22                      : std_logic;  -- ufix1
  SIGNAL checksumReg_20                   : std_logic;  -- ufix1
  SIGNAL tcs_entry21                      : std_logic;  -- ufix1
  SIGNAL checksumReg_19                   : std_logic;  -- ufix1
  SIGNAL tcs_entry20                      : std_logic;  -- ufix1
  SIGNAL checksumReg_18                   : std_logic;  -- ufix1
  SIGNAL tcs_entry19                      : std_logic;  -- ufix1
  SIGNAL checksumReg_17                   : std_logic;  -- ufix1
  SIGNAL tcs_entry18                      : std_logic;  -- ufix1
  SIGNAL checksumReg_16                   : std_logic;  -- ufix1
  SIGNAL tcs_entry17                      : std_logic;  -- ufix1
  SIGNAL checksumReg_15                   : std_logic;  -- ufix1
  SIGNAL tcs_entry16                      : std_logic;  -- ufix1
  SIGNAL checksumReg_14                   : std_logic;  -- ufix1
  SIGNAL tcs_entry15                      : std_logic;  -- ufix1
  SIGNAL checksumReg_13                   : std_logic;  -- ufix1
  SIGNAL tcs_entry14                      : std_logic;  -- ufix1
  SIGNAL checksumReg_12                   : std_logic;  -- ufix1
  SIGNAL tcs_entry13                      : std_logic;  -- ufix1
  SIGNAL checksumReg_11                   : std_logic;  -- ufix1
  SIGNAL tcs_entry12                      : std_logic;  -- ufix1
  SIGNAL checksumReg_10                   : std_logic;  -- ufix1
  SIGNAL tcs_entry11                      : std_logic;  -- ufix1
  SIGNAL checksumReg_9                    : std_logic;  -- ufix1
  SIGNAL tcs_entry10                      : std_logic;  -- ufix1
  SIGNAL checksumReg_8                    : std_logic;  -- ufix1
  SIGNAL tcs_entry9                       : std_logic;  -- ufix1
  SIGNAL checksumReg_7                    : std_logic;  -- ufix1
  SIGNAL tcs_entry8                       : std_logic;  -- ufix1
  SIGNAL checksumReg_6                    : std_logic;  -- ufix1
  SIGNAL tcs_entry7                       : std_logic;  -- ufix1
  SIGNAL checksumReg_5                    : std_logic;  -- ufix1
  SIGNAL tcs_entry6                       : std_logic;  -- ufix1
  SIGNAL checksumReg_4                    : std_logic;  -- ufix1
  SIGNAL tcs_entry5                       : std_logic;  -- ufix1
  SIGNAL checksumReg_3                    : std_logic;  -- ufix1
  SIGNAL tcs_entry4                       : std_logic;  -- ufix1
  SIGNAL checksumReg_2                    : std_logic;  -- ufix1
  SIGNAL tcs_entry3                       : std_logic;  -- ufix1
  SIGNAL checksumReg_1                    : std_logic;  -- ufix1
  SIGNAL tcs_entry2                       : std_logic;  -- ufix1
  SIGNAL checksumReg_0                    : std_logic;  -- ufix1
  SIGNAL tcs_entry1                       : std_logic;  -- ufix1
  SIGNAL tcs_entry0                       : std_logic;  -- ufix1
  SIGNAL tchecksum                        : std_logic_vector(0 TO 31);  -- ufix1 [32]
  SIGNAL finalChecksum                    : std_logic_vector(0 TO 31);  -- ufix1 [32]

BEGIN
  counter_unsigned <= unsigned(counter);

  
  xoredSel <= '1' WHEN counter_unsigned = to_unsigned(16#1F#, 5) ELSE
      '0';

  validin_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dvalidin <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        dvalidin <= validIn;
      END IF;
    END IF;
  END PROCESS validin_register_process;


  tcsSel <= processMsg AND dvalidin;

  csSel <= tcsSel OR padZero;

  rpadZero <=  NOT padZero;

  -- Selection signal: Select input data or pad zeros
  dataSel <= rpadZero AND dvalidin;

  -- Padding zeros
  padingzeros(0) <= '0';
  padingzeros(1) <= '0';
  padingzeros(2) <= '0';
  padingzeros(3) <= '0';
  padingzeros(4) <= '0';
  padingzeros(5) <= '0';
  padingzeros(6) <= '0';
  padingzeros(7) <= '0';
  padingzeros(8) <= '0';
  padingzeros(9) <= '0';
  padingzeros(10) <= '0';
  padingzeros(11) <= '0';
  padingzeros(12) <= '0';
  padingzeros(13) <= '0';
  padingzeros(14) <= '0';
  padingzeros(15) <= '0';
  padingzeros(16) <= '0';
  padingzeros(17) <= '0';
  padingzeros(18) <= '0';
  padingzeros(19) <= '0';
  padingzeros(20) <= '0';
  padingzeros(21) <= '0';
  padingzeros(22) <= '0';
  padingzeros(23) <= '0';
  padingzeros(24) <= '0';
  padingzeros(25) <= '0';
  padingzeros(26) <= '0';
  padingzeros(27) <= '0';
  padingzeros(28) <= '0';
  padingzeros(29) <= '0';
  padingzeros(30) <= '0';
  padingzeros(31) <= '0';

  inputzeros(0) <= '0';
  inputzeros(1) <= '0';
  inputzeros(2) <= '0';
  inputzeros(3) <= '0';
  inputzeros(4) <= '0';
  inputzeros(5) <= '0';
  inputzeros(6) <= '0';
  inputzeros(7) <= '0';
  inputzeros(8) <= '0';
  inputzeros(9) <= '0';
  inputzeros(10) <= '0';
  inputzeros(11) <= '0';
  inputzeros(12) <= '0';
  inputzeros(13) <= '0';
  inputzeros(14) <= '0';
  inputzeros(15) <= '0';
  inputzeros(16) <= '0';
  inputzeros(17) <= '0';
  inputzeros(18) <= '0';
  inputzeros(19) <= '0';
  inputzeros(20) <= '0';
  inputzeros(21) <= '0';
  inputzeros(22) <= '0';
  inputzeros(23) <= '0';
  inputzeros(24) <= '0';
  inputzeros(25) <= '0';
  inputzeros(26) <= '0';
  inputzeros(27) <= '0';
  inputzeros(28) <= '0';
  inputzeros(29) <= '0';
  inputzeros(30) <= '0';

  -- Prepare inputs for parallel CRC computation
  datamux(0) <= inputzeros(0);
  datamux(1) <= inputzeros(1);
  datamux(2) <= inputzeros(2);
  datamux(3) <= inputzeros(3);
  datamux(4) <= inputzeros(4);
  datamux(5) <= inputzeros(5);
  datamux(6) <= inputzeros(6);
  datamux(7) <= inputzeros(7);
  datamux(8) <= inputzeros(8);
  datamux(9) <= inputzeros(9);
  datamux(10) <= inputzeros(10);
  datamux(11) <= inputzeros(11);
  datamux(12) <= inputzeros(12);
  datamux(13) <= inputzeros(13);
  datamux(14) <= inputzeros(14);
  datamux(15) <= inputzeros(15);
  datamux(16) <= inputzeros(16);
  datamux(17) <= inputzeros(17);
  datamux(18) <= inputzeros(18);
  datamux(19) <= inputzeros(19);
  datamux(20) <= inputzeros(20);
  datamux(21) <= inputzeros(21);
  datamux(22) <= inputzeros(22);
  datamux(23) <= inputzeros(23);
  datamux(24) <= inputzeros(24);
  datamux(25) <= inputzeros(25);
  datamux(26) <= inputzeros(26);
  datamux(27) <= inputzeros(27);
  datamux(28) <= inputzeros(28);
  datamux(29) <= inputzeros(29);
  datamux(30) <= inputzeros(30);
  datamux(31) <= datainReg;

  -- Switch between input data and padded zeros
  
  datacpt <= padingzeros WHEN dataSel = '0' ELSE
      datamux;

  datacpt_31 <= datacpt(31);

  datacpt_30 <= datacpt(30);

  datacpt_29 <= datacpt(29);

  datacpt_28 <= datacpt(28);

  datacpt_27 <= datacpt(27);

  datacpt_26 <= datacpt(26);

  datacpt_25 <= datacpt(25);

  datacpt_24 <= datacpt(24);

  datacpt_23 <= datacpt(23);

  datacpt_22 <= datacpt(22);

  datacpt_21 <= datacpt(21);

  datacpt_20 <= datacpt(20);

  datacpt_19 <= datacpt(19);

  datacpt_18 <= datacpt(18);

  datacpt_17 <= datacpt(17);

  datacpt_16 <= datacpt(16);

  datacpt_15 <= datacpt(15);

  datacpt_14 <= datacpt(14);

  datacpt_13 <= datacpt(13);

  datacpt_12 <= datacpt(12);

  datacpt_11 <= datacpt(11);

  datacpt_10 <= datacpt(10);

  datacpt_9 <= datacpt(9);

  datacpt_8 <= datacpt(8);

  datacpt_7 <= datacpt(7);

  datacpt_6 <= datacpt(6);

  datacpt_5 <= datacpt(5);

  datacpt_4 <= datacpt(4);

  datacpt_3 <= datacpt(3);

  datacpt_2 <= datacpt(2);

  datacpt_1 <= datacpt(1);

  datacpt_0 <= datacpt(0);

  -- Compute finalXor
  finalXorValue(0) <= '0';
  finalXorValue(1) <= '0';
  finalXorValue(2) <= '0';
  finalXorValue(3) <= '0';
  finalXorValue(4) <= '0';
  finalXorValue(5) <= '0';
  finalXorValue(6) <= '0';
  finalXorValue(7) <= '0';
  finalXorValue(8) <= '0';
  finalXorValue(9) <= '0';
  finalXorValue(10) <= '0';
  finalXorValue(11) <= '0';
  finalXorValue(12) <= '0';
  finalXorValue(13) <= '0';
  finalXorValue(14) <= '0';
  finalXorValue(15) <= '0';
  finalXorValue(16) <= '0';
  finalXorValue(17) <= '0';
  finalXorValue(18) <= '0';
  finalXorValue(19) <= '0';
  finalXorValue(20) <= '0';
  finalXorValue(21) <= '0';
  finalXorValue(22) <= '0';
  finalXorValue(23) <= '0';
  finalXorValue(24) <= '0';
  finalXorValue(25) <= '0';
  finalXorValue(26) <= '0';
  finalXorValue(27) <= '0';
  finalXorValue(28) <= '0';
  finalXorValue(29) <= '0';
  finalXorValue(30) <= '0';
  finalXorValue(31) <= '0';

  finalXorValue_0 <= finalXorValue(0);

  finalXorValue_1 <= finalXorValue(1);

  finalXorValue_2 <= finalXorValue(2);

  finalXorValue_3 <= finalXorValue(3);

  finalXorValue_4 <= finalXorValue(4);

  finalXorValue_5 <= finalXorValue(5);

  finalXorValue_6 <= finalXorValue(6);

  finalXorValue_7 <= finalXorValue(7);

  finalXorValue_8 <= finalXorValue(8);

  finalXorValue_9 <= finalXorValue(9);

  finalXorValue_10 <= finalXorValue(10);

  finalXorValue_11 <= finalXorValue(11);

  finalXorValue_12 <= finalXorValue(12);

  finalXorValue_13 <= finalXorValue(13);

  finalXorValue_14 <= finalXorValue(14);

  finalXorValue_15 <= finalXorValue(15);

  finalXorValue_16 <= finalXorValue(16);

  finalXorValue_17 <= finalXorValue(17);

  finalXorValue_18 <= finalXorValue(18);

  finalXorValue_19 <= finalXorValue(19);

  finalXorValue_20 <= finalXorValue(20);

  finalXorValue_21 <= finalXorValue(21);

  finalXorValue_22 <= finalXorValue(22);

  finalXorValue_23 <= finalXorValue(23);

  finalXorValue_24 <= finalXorValue(24);

  finalXorValue_25 <= finalXorValue(25);

  finalXorValue_26 <= finalXorValue(26);

  finalXorValue_27 <= finalXorValue(27);

  finalXorValue_28 <= finalXorValue(28);

  finalXorValue_29 <= finalXorValue(29);

  finalXorValue_30 <= finalXorValue(30);

  finalXorValue_31 <= finalXorValue(31);

  -- Reflect Checksum and make checksum LSB first
  newChecksum_0 <= newChecksum(0);

  refelctCheckSum_31 <= newChecksum_0 XOR finalXorValue_31;

  newChecksum_1 <= newChecksum(1);

  refelctCheckSum_30 <= newChecksum_1 XOR finalXorValue_30;

  newChecksum_2 <= newChecksum(2);

  refelctCheckSum_29 <= newChecksum_2 XOR finalXorValue_29;

  newChecksum_3 <= newChecksum(3);

  refelctCheckSum_28 <= newChecksum_3 XOR finalXorValue_28;

  newChecksum_4 <= newChecksum(4);

  refelctCheckSum_27 <= newChecksum_4 XOR finalXorValue_27;

  newChecksum_5 <= newChecksum(5);

  refelctCheckSum_26 <= newChecksum_5 XOR finalXorValue_26;

  newChecksum_6 <= newChecksum(6);

  refelctCheckSum_25 <= newChecksum_6 XOR finalXorValue_25;

  newChecksum_7 <= newChecksum(7);

  refelctCheckSum_24 <= newChecksum_7 XOR finalXorValue_24;

  newChecksum_8 <= newChecksum(8);

  refelctCheckSum_23 <= newChecksum_8 XOR finalXorValue_23;

  newChecksum_9 <= newChecksum(9);

  refelctCheckSum_22 <= newChecksum_9 XOR finalXorValue_22;

  newChecksum_10 <= newChecksum(10);

  refelctCheckSum_21 <= newChecksum_10 XOR finalXorValue_21;

  newChecksum_11 <= newChecksum(11);

  refelctCheckSum_20 <= newChecksum_11 XOR finalXorValue_20;

  newChecksum_12 <= newChecksum(12);

  refelctCheckSum_19 <= newChecksum_12 XOR finalXorValue_19;

  newChecksum_13 <= newChecksum(13);

  refelctCheckSum_18 <= newChecksum_13 XOR finalXorValue_18;

  newChecksum_14 <= newChecksum(14);

  refelctCheckSum_17 <= newChecksum_14 XOR finalXorValue_17;

  newChecksum_15 <= newChecksum(15);

  refelctCheckSum_16 <= newChecksum_15 XOR finalXorValue_16;

  newChecksum_16 <= newChecksum(16);

  refelctCheckSum_15 <= newChecksum_16 XOR finalXorValue_15;

  newChecksum_17 <= newChecksum(17);

  refelctCheckSum_14 <= newChecksum_17 XOR finalXorValue_14;

  newChecksum_18 <= newChecksum(18);

  refelctCheckSum_13 <= newChecksum_18 XOR finalXorValue_13;

  newChecksum_19 <= newChecksum(19);

  refelctCheckSum_12 <= newChecksum_19 XOR finalXorValue_12;

  newChecksum_20 <= newChecksum(20);

  refelctCheckSum_11 <= newChecksum_20 XOR finalXorValue_11;

  newChecksum_21 <= newChecksum(21);

  refelctCheckSum_10 <= newChecksum_21 XOR finalXorValue_10;

  newChecksum_22 <= newChecksum(22);

  refelctCheckSum_9 <= newChecksum_22 XOR finalXorValue_9;

  newChecksum_23 <= newChecksum(23);

  refelctCheckSum_8 <= newChecksum_23 XOR finalXorValue_8;

  newChecksum_24 <= newChecksum(24);

  refelctCheckSum_7 <= newChecksum_24 XOR finalXorValue_7;

  newChecksum_25 <= newChecksum(25);

  refelctCheckSum_6 <= newChecksum_25 XOR finalXorValue_6;

  newChecksum_26 <= newChecksum(26);

  refelctCheckSum_5 <= newChecksum_26 XOR finalXorValue_5;

  newChecksum_27 <= newChecksum(27);

  refelctCheckSum_4 <= newChecksum_27 XOR finalXorValue_4;

  newChecksum_28 <= newChecksum(28);

  refelctCheckSum_3 <= newChecksum_28 XOR finalXorValue_3;

  newChecksum_29 <= newChecksum(29);

  refelctCheckSum_2 <= newChecksum_29 XOR finalXorValue_2;

  newChecksum_30 <= newChecksum(30);

  refelctCheckSum_1 <= newChecksum_30 XOR finalXorValue_1;

  newChecksum_31 <= newChecksum(31);

  refelctCheckSum_0 <= newChecksum_31 XOR finalXorValue_0;

  xoredChecksum(0) <= refelctCheckSum_0;
  xoredChecksum(1) <= refelctCheckSum_1;
  xoredChecksum(2) <= refelctCheckSum_2;
  xoredChecksum(3) <= refelctCheckSum_3;
  xoredChecksum(4) <= refelctCheckSum_4;
  xoredChecksum(5) <= refelctCheckSum_5;
  xoredChecksum(6) <= refelctCheckSum_6;
  xoredChecksum(7) <= refelctCheckSum_7;
  xoredChecksum(8) <= refelctCheckSum_8;
  xoredChecksum(9) <= refelctCheckSum_9;
  xoredChecksum(10) <= refelctCheckSum_10;
  xoredChecksum(11) <= refelctCheckSum_11;
  xoredChecksum(12) <= refelctCheckSum_12;
  xoredChecksum(13) <= refelctCheckSum_13;
  xoredChecksum(14) <= refelctCheckSum_14;
  xoredChecksum(15) <= refelctCheckSum_15;
  xoredChecksum(16) <= refelctCheckSum_16;
  xoredChecksum(17) <= refelctCheckSum_17;
  xoredChecksum(18) <= refelctCheckSum_18;
  xoredChecksum(19) <= refelctCheckSum_19;
  xoredChecksum(20) <= refelctCheckSum_20;
  xoredChecksum(21) <= refelctCheckSum_21;
  xoredChecksum(22) <= refelctCheckSum_22;
  xoredChecksum(23) <= refelctCheckSum_23;
  xoredChecksum(24) <= refelctCheckSum_24;
  xoredChecksum(25) <= refelctCheckSum_25;
  xoredChecksum(26) <= refelctCheckSum_26;
  xoredChecksum(27) <= refelctCheckSum_27;
  xoredChecksum(28) <= refelctCheckSum_28;
  xoredChecksum(29) <= refelctCheckSum_29;
  xoredChecksum(30) <= refelctCheckSum_30;
  xoredChecksum(31) <= refelctCheckSum_31;

  checksumReg_30 <= checksumReg(30);

  -- Compute checksum element32
  tcs_entry31 <= checksumReg_30 XOR datacpt_0;

  checksumReg_29 <= checksumReg(29);

  -- Compute checksum element31
  tcs_entry30 <= checksumReg_29 XOR datacpt_1;

  checksumReg_28 <= checksumReg(28);

  -- Compute checksum element30
  tcs_entry29 <= checksumReg_28 XOR datacpt_2;

  checksumReg_27 <= checksumReg(27);

  -- Compute checksum element29
  tcs_entry28 <= checksumReg_27 XOR datacpt_3;

  checksumReg_26 <= checksumReg(26);

  -- Compute checksum element28
  tcs_entry27 <= checksumReg_26 XOR datacpt_4;

  checksumReg_25 <= checksumReg(25);

  -- Compute checksum element27
  tcs_entry26 <= datacpt_5 XOR (checksumReg_31 XOR checksumReg_25);

  checksumReg_24 <= checksumReg(24);

  -- Compute checksum element26
  tcs_entry25 <= checksumReg_24 XOR datacpt_6;

  checksumReg_23 <= checksumReg(23);

  -- Compute checksum element25
  tcs_entry24 <= checksumReg_23 XOR datacpt_7;

  checksumReg_22 <= checksumReg(22);

  -- Compute checksum element24
  tcs_entry23 <= datacpt_8 XOR (checksumReg_31 XOR checksumReg_22);

  checksumReg_21 <= checksumReg(21);

  -- Compute checksum element23
  tcs_entry22 <= datacpt_9 XOR (checksumReg_31 XOR checksumReg_21);

  checksumReg_20 <= checksumReg(20);

  -- Compute checksum element22
  tcs_entry21 <= checksumReg_20 XOR datacpt_10;

  checksumReg_19 <= checksumReg(19);

  -- Compute checksum element21
  tcs_entry20 <= checksumReg_19 XOR datacpt_11;

  checksumReg_18 <= checksumReg(18);

  -- Compute checksum element20
  tcs_entry19 <= checksumReg_18 XOR datacpt_12;

  checksumReg_17 <= checksumReg(17);

  -- Compute checksum element19
  tcs_entry18 <= checksumReg_17 XOR datacpt_13;

  checksumReg_16 <= checksumReg(16);

  -- Compute checksum element18
  tcs_entry17 <= checksumReg_16 XOR datacpt_14;

  checksumReg_15 <= checksumReg(15);

  -- Compute checksum element17
  tcs_entry16 <= datacpt_15 XOR (checksumReg_31 XOR checksumReg_15);

  checksumReg_14 <= checksumReg(14);

  -- Compute checksum element16
  tcs_entry15 <= checksumReg_14 XOR datacpt_16;

  checksumReg_13 <= checksumReg(13);

  -- Compute checksum element15
  tcs_entry14 <= checksumReg_13 XOR datacpt_17;

  checksumReg_12 <= checksumReg(12);

  -- Compute checksum element14
  tcs_entry13 <= checksumReg_12 XOR datacpt_18;

  checksumReg_11 <= checksumReg(11);

  -- Compute checksum element13
  tcs_entry12 <= datacpt_19 XOR (checksumReg_31 XOR checksumReg_11);

  checksumReg_10 <= checksumReg(10);

  -- Compute checksum element12
  tcs_entry11 <= datacpt_20 XOR (checksumReg_31 XOR checksumReg_10);

  checksumReg_9 <= checksumReg(9);

  -- Compute checksum element11
  tcs_entry10 <= datacpt_21 XOR (checksumReg_31 XOR checksumReg_9);

  checksumReg_8 <= checksumReg(8);

  -- Compute checksum element10
  tcs_entry9 <= checksumReg_8 XOR datacpt_22;

  checksumReg_7 <= checksumReg(7);

  -- Compute checksum element9
  tcs_entry8 <= datacpt_23 XOR (checksumReg_31 XOR checksumReg_7);

  checksumReg_6 <= checksumReg(6);

  -- Compute checksum element8
  tcs_entry7 <= datacpt_24 XOR (checksumReg_31 XOR checksumReg_6);

  checksumReg_5 <= checksumReg(5);

  -- Compute checksum element7
  tcs_entry6 <= checksumReg_5 XOR datacpt_25;

  checksumReg_4 <= checksumReg(4);

  -- Compute checksum element6
  tcs_entry5 <= datacpt_26 XOR (checksumReg_31 XOR checksumReg_4);

  checksumReg_3 <= checksumReg(3);

  -- Compute checksum element5
  tcs_entry4 <= datacpt_27 XOR (checksumReg_31 XOR checksumReg_3);

  checksumReg_2 <= checksumReg(2);

  -- Compute checksum element4
  tcs_entry3 <= checksumReg_2 XOR datacpt_28;

  checksumReg_1 <= checksumReg(1);

  -- Compute checksum element3
  tcs_entry2 <= datacpt_29 XOR (checksumReg_31 XOR checksumReg_1);

  checksumReg_0 <= checksumReg(0);

  -- Compute checksum element2
  tcs_entry1 <= datacpt_30 XOR (checksumReg_31 XOR checksumReg_0);

  checksumReg_31 <= checksumReg(31);

  -- Compute checksum element1
  -- 
  -- Checksum selection signal
  tcs_entry0 <= checksumReg_31 XOR datacpt_31;

  tchecksum(0) <= tcs_entry0;
  tchecksum(1) <= tcs_entry1;
  tchecksum(2) <= tcs_entry2;
  tchecksum(3) <= tcs_entry3;
  tchecksum(4) <= tcs_entry4;
  tchecksum(5) <= tcs_entry5;
  tchecksum(6) <= tcs_entry6;
  tchecksum(7) <= tcs_entry7;
  tchecksum(8) <= tcs_entry8;
  tchecksum(9) <= tcs_entry9;
  tchecksum(10) <= tcs_entry10;
  tchecksum(11) <= tcs_entry11;
  tchecksum(12) <= tcs_entry12;
  tchecksum(13) <= tcs_entry13;
  tchecksum(14) <= tcs_entry14;
  tchecksum(15) <= tcs_entry15;
  tchecksum(16) <= tcs_entry16;
  tchecksum(17) <= tcs_entry17;
  tchecksum(18) <= tcs_entry18;
  tchecksum(19) <= tcs_entry19;
  tchecksum(20) <= tcs_entry20;
  tchecksum(21) <= tcs_entry21;
  tchecksum(22) <= tcs_entry22;
  tchecksum(23) <= tcs_entry23;
  tchecksum(24) <= tcs_entry24;
  tchecksum(25) <= tcs_entry25;
  tchecksum(26) <= tcs_entry26;
  tchecksum(27) <= tcs_entry27;
  tchecksum(28) <= tcs_entry28;
  tchecksum(29) <= tcs_entry29;
  tchecksum(30) <= tcs_entry30;
  tchecksum(31) <= tcs_entry31;

  checksum_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      checksumReg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        IF xoredSel = '1' THEN
          checksumReg <= (OTHERS => '0');
        ELSE 
          checksumReg <= finalChecksum;
        END IF;
      END IF;
    END IF;
  END PROCESS checksum_register_process;


  -- Update checksum register for valid inputs
  
  newChecksum <= checksumReg WHEN csSel = '0' ELSE
      tchecksum;

  -- Xor after computing the checksum
  
  finalChecksum <= newChecksum WHEN xoredSel = '0' ELSE
      xoredChecksum;

  -- 1
  outputchecksum_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      crcChecksum <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' AND xoredSel = '1' THEN
        crcChecksum <= finalChecksum;
      END IF;
    END IF;
  END PROCESS outputchecksum_register_process;


END rtl;

