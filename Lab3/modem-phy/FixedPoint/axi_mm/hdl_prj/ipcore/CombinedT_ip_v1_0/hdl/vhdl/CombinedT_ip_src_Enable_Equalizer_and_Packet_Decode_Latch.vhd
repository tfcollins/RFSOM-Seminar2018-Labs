-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch.vhd
-- Created: 2018-02-01 18:12:06
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Frame Recover/Enable Equalizer and Packet Decode 
-- (Latch
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        start                             :   IN    std_logic;
        validIn                           :   IN    std_logic;
        enable                            :   OUT   std_logic
        );
END CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch;


ARCHITECTURE rtl OF CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch IS

  -- Signals
  SIGNAL delayMatch_reg                   : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL validIn_1                        : std_logic;
  SIGNAL count                            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL lastEOF                          : std_logic;
  SIGNAL count_next                       : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL lastEOF_next                     : std_logic;

BEGIN
  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= validIn;
        delayMatch_reg(1) <= delayMatch_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  validIn_1 <= delayMatch_reg(1);

  RxTxFixedPointLibrary_c12_Enable_Equalizer_and_Packet_Decode_L_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count <= to_unsigned(16#00000000#, 32);
      lastEOF <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        count <= count_next;
        lastEOF <= lastEOF_next;
      END IF;
    END IF;
  END PROCESS RxTxFixedPointLibrary_c12_Enable_Equalizer_and_Packet_Decode_L_process;

  RxTxFixedPointLibrary_c12_Enable_Equalizer_and_Packet_Decode_L_output : PROCESS (start, validIn_1, count, lastEOF)
    VARIABLE count_temp : unsigned(31 DOWNTO 0);
    VARIABLE sub_cast : signed(32 DOWNTO 0);
    VARIABLE sub_temp : signed(32 DOWNTO 0);
  BEGIN
    count_temp := count;
    lastEOF_next <= lastEOF;
    IF validIn_1 = '1' THEN 
      -- Got a barker preamble start allowing data into equalizer
      IF start = '1' THEN 
        count_temp := to_unsigned(16#00010000#, 32);
      END IF;
      -- Check on change from true to false
      IF lastEOF = '1' THEN 
        --     fprintf('Frame end reached\n');
        count_temp := to_unsigned(16#00000000#, 32);
      END IF;
      lastEOF_next <= '0';
      -- Past end of max frame size
      IF count_temp > to_unsigned(16#00000000#, 32) THEN 
        sub_cast := signed(resize(count_temp, 33));
        sub_temp := sub_cast - to_signed(1, 33);
        IF sub_temp(32) = '1' THEN 
          count_temp := X"00000000";
        ELSE 
          count_temp := unsigned(sub_temp(31 DOWNTO 0));
        END IF;
      END IF;
      -- Enable downstream
      IF count_temp > to_unsigned(16#00000000#, 32) THEN 
        enable <= '1';
      ELSE 
        enable <= '0';
      END IF;
    ELSE 
      enable <= '0';
    END IF;
    count_next <= count_temp;
  END PROCESS RxTxFixedPointLibrary_c12_Enable_Equalizer_and_Packet_Decode_L_output;


END rtl;

