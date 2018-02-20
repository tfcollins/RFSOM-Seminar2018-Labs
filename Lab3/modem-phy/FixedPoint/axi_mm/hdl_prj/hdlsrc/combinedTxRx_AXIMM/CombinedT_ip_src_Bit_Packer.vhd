-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_src_Bit_Packer.vhd
-- Created: 2018-02-01 18:12:05
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Bit_Packer
-- Source Path: combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/CRC Check and DMA Pack/DMA Interface/Bit Packer
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Bit_Packer IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        bitIn                             :   IN    std_logic;
        startIn                           :   IN    std_logic;
        endIn                             :   IN    std_logic;
        err                               :   IN    std_logic;
        validIn                           :   IN    std_logic;
        byteOut                           :   OUT   std_logic_vector(63 DOWNTO 0);  -- ufix64
        validOut                          :   OUT   std_logic;
        startOut                          :   OUT   std_logic
        );
END CombinedT_ip_src_Bit_Packer;


ARCHITECTURE rtl OF CombinedT_ip_src_Bit_Packer IS

  -- Signals
  SIGNAL byteOut_tmp                      : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL byteReg                          : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL byteIndx                         : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL setStartFlag                     : std_logic;
  SIGNAL byteReg_next                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL byteIndx_next                    : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL setStartFlag_next                : std_logic;

BEGIN
  RxTxFixedPointLibrary_c11_Bit_Packer_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      byteReg <= to_unsigned(0, 64);
      byteIndx <= to_unsigned(16#01#, 8);
      setStartFlag <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        byteReg <= byteReg_next;
        byteIndx <= byteIndx_next;
        setStartFlag <= setStartFlag_next;
      END IF;
    END IF;
  END PROCESS RxTxFixedPointLibrary_c11_Bit_Packer_process;

  RxTxFixedPointLibrary_c11_Bit_Packer_output : PROCESS (bitIn, startIn, endIn, err, validIn, byteReg, byteIndx, setStartFlag)
    VARIABLE bit_idx : unsigned(7 DOWNTO 0);
    VARIABLE mask : unsigned(63 DOWNTO 0);
    VARIABLE byteReg_temp : unsigned(63 DOWNTO 0);
    VARIABLE add_temp : unsigned(8 DOWNTO 0);
  BEGIN
    byteReg_temp := byteReg;
    byteIndx_next <= byteIndx;
    setStartFlag_next <= setStartFlag;
    -- This block will pack bits into bytes with start boundaries
    -- Constants
    -- byteReg must contain this many bits
    -- NOTE: Frames but be a multiple of bits2Pack or bits will be trimmed from
    -- end
    IF validIn = '1' THEN 
      IF startIn = '1' THEN 
        -- Reset
        IF bitIn = '1' THEN 
          byteReg_temp := to_unsigned(1, 64);
        ELSE 
          byteReg_temp := to_unsigned(0, 64);
        END IF;
        byteIndx_next <= to_unsigned(16#02#, 8);
        validOut <= '0';
        setStartFlag_next <= '1';
        startOut <= '0';
      ELSE 
        IF (byteIndx >= to_unsigned(16#00000001#, 8)) AND (byteIndx <= to_unsigned(16#00000040#, 8)) THEN 
          bit_idx := byteIndx - 1;
          mask := to_unsigned(1, 64) sll to_integer(bit_idx);
          IF bitIn = '1' THEN 
            byteReg_temp := byteReg OR mask;
          ELSE 
            byteReg_temp := byteReg AND ( NOT mask);
          END IF;
        END IF;
        IF byteIndx >= to_unsigned(16#00000040#, 8) THEN 
          byteIndx_next <= to_unsigned(16#01#, 8);
          validOut <= '1';
          startOut <= setStartFlag;
          setStartFlag_next <= '0';
        ELSE 
          add_temp := resize(byteIndx, 9) + to_unsigned(16#001#, 9);
          IF add_temp(8) /= '0' THEN 
            byteIndx_next <= "11111111";
          ELSE 
            byteIndx_next <= add_temp(7 DOWNTO 0);
          END IF;
          validOut <= '0';
          startOut <= '0';
        END IF;
      END IF;
    ELSIF endIn = '1' THEN 
      -- Append error bit to last byte
      byteReg_temp := '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & err;
      validOut <= '1';
      startOut <= '0';
    ELSE 
      validOut <= '0';
      startOut <= '0';
    END IF;
    byteOut_tmp <= byteReg_temp;
    byteReg_next <= byteReg_temp;
  END PROCESS RxTxFixedPointLibrary_c11_Bit_Packer_output;


  byteOut <= std_logic_vector(byteOut_tmp);

END rtl;

