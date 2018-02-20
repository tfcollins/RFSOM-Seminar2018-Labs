-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_Header_Controller.vhd
-- Created: 2018-02-01 13:20:09
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Header_Controller
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/Frame Recover/Equalization and Demodulation/Header 
-- Controlle
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_Header_Controller IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        headerStart                       :   IN    std_logic;
        data                              :   IN    std_logic_vector(0 TO 1);  -- boolean [2]
        enableDownstream                  :   OUT   std_logic;
        packetLenBitsOut                  :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        resetViterbi                      :   OUT   std_logic;
        crcStart                          :   OUT   std_logic;
        status                            :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        s1                                :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        s2                                :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
        );
END CombinedT_ip_src_Header_Controller;


ARCHITECTURE rtl OF CombinedT_ip_src_Header_Controller IS

  -- Constants
  CONSTANT nc                             : vector_of_unsigned16(0 TO 15) := 
    (to_unsigned(16#0001#, 16), to_unsigned(16#0002#, 16), to_unsigned(16#0004#, 16), to_unsigned(16#0008#, 16),
     to_unsigned(16#0010#, 16), to_unsigned(16#0020#, 16), to_unsigned(16#0040#, 16), to_unsigned(16#0080#, 16),
     to_unsigned(16#0100#, 16), to_unsigned(16#0200#, 16), to_unsigned(16#0400#, 16), to_unsigned(16#0800#, 16),
     to_unsigned(16#1000#, 16), to_unsigned(16#2000#, 16), to_unsigned(16#4000#, 16), to_unsigned(16#8000#, 16));  -- uint16 [16]

  -- Signals
  SIGNAL packetLenBitsOut_tmp             : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL status_tmp                       : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL s1_tmp                           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL s2_tmp                           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL counter                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL sum1                             : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL sum2                             : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL packetLenBits                    : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL lastMode                         : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL savedPacketLenBits               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL counter_next                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL sum1_next                        : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL sum2_next                        : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL packetLenBits_next               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL lastMode_next                    : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL savedPacketLenBits_next          : unsigned(15 DOWNTO 0);  -- uint16

BEGIN
  RxTxFixedPointLibrary_c15_Header_Controller_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      packetLenBits <= to_unsigned(16#00000000#, 32);
      sum1 <= to_unsigned(16#00000000#, 32);
      sum2 <= to_unsigned(16#00000000#, 32);
      counter <= to_unsigned(16#10#, 8);
      lastMode <= to_unsigned(16#03#, 8);
      savedPacketLenBits <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        counter <= counter_next;
        sum1 <= sum1_next;
        sum2 <= sum2_next;
        packetLenBits <= packetLenBits_next;
        lastMode <= lastMode_next;
        savedPacketLenBits <= savedPacketLenBits_next;
      END IF;
    END IF;
  END PROCESS RxTxFixedPointLibrary_c15_Header_Controller_process;

  RxTxFixedPointLibrary_c15_Header_Controller_output : PROCESS (headerStart, data, counter, sum1, sum2, packetLenBits, lastMode,
       savedPacketLenBits)
    VARIABLE mode : unsigned(7 DOWNTO 0);
    VARIABLE counter_temp : unsigned(7 DOWNTO 0);
    VARIABLE sum1_temp : unsigned(31 DOWNTO 0);
    VARIABLE sum2_temp : unsigned(31 DOWNTO 0);
    VARIABLE sub_cast : signed(31 DOWNTO 0);
    VARIABLE add_temp : unsigned(32 DOWNTO 0);
    VARIABLE sub_cast_0 : signed(31 DOWNTO 0);
    VARIABLE add_temp_0 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_1 : unsigned(8 DOWNTO 0);
    VARIABLE sub_cast_1 : signed(32 DOWNTO 0);
    VARIABLE sub_temp : signed(32 DOWNTO 0);
    VARIABLE sub_cast_2 : signed(32 DOWNTO 0);
    VARIABLE sub_temp_0 : signed(32 DOWNTO 0);
    VARIABLE sub_cast_3 : signed(32 DOWNTO 0);
    VARIABLE sub_temp_1 : signed(32 DOWNTO 0);
  BEGIN
    counter_temp := counter;
    sum1_temp := sum1;
    sum2_temp := sum2;
    packetLenBits_next <= packetLenBits;
    lastMode_next <= lastMode;
    savedPacketLenBits_next <= savedPacketLenBits;
    -- The header contains 16 bits, but each bit is duplicated to make checking
    -- easier
    --
    -- Note this block works on symbols (2bits) but 1 symbol -> 1 decoded bit
    --
    -- PacketLength = (Data+CRC+40(TB)+68)/CodeRate
    --
    -- NOTE TAIL BITS HERE ARE REALLY USED TO DEAL WITH VITERBI LAG SO:
    -- TailBitsWithLagPadding > TracebackLength
    -- Constants
    -- Header is this many bits
    --1/CodeRate;
    -- was +1
    -- Flag when CRC porition of packet starts relative to header
    -- Must be even
    -- Async
    -- Sync
    -- Got a header now enable certain mode
    IF headerStart = '1' THEN 
      mode := to_unsigned(16#00#, 8);
    ELSE 
      mode := lastMode;
    END IF;
    CASE mode IS
      WHEN "00000000" =>
        --    %% Reset on preamble flag and setup for header processing
        crcStart <= '0';
        resetViterbi <= '0';
        enableDownstream <= '0';
        sum1_temp := to_unsigned(16#00000000#, 32);
        sum2_temp := to_unsigned(16#00000000#, 32);
        counter_temp := to_unsigned(16#01#, 8);
        lastMode_next <= to_unsigned(16#01#, 8);
        -- Go to next state
        packetLenBitsOut_tmp <= to_unsigned(16#0000#, 16);
        status_tmp <= to_unsigned(16#00#, 8);
        s1_tmp <= to_unsigned(16#00000000#, 32);
        s2_tmp <= to_unsigned(16#00000000#, 32);
        --    %% Process header
      WHEN "00000001" =>
        crcStart <= '0';
        enableDownstream <= '0';
        -- Convert header bits (bit by bit)
        IF data(0) = '1' THEN 
          sub_cast := signed(resize(counter, 32));
          add_temp := resize(sum1, 33) + resize(nc(to_integer(sub_cast - 1)), 33);
          IF add_temp(32) /= '0' THEN 
            sum1_temp := X"FFFFFFFF";
          ELSE 
            sum1_temp := add_temp(31 DOWNTO 0);
          END IF;
        END IF;
        IF data(1) = '1' THEN 
          sub_cast_0 := signed(resize(counter, 32));
          add_temp_0 := resize(sum2, 33) + resize(nc(to_integer(sub_cast_0 - 1)), 33);
          IF add_temp_0(32) /= '0' THEN 
            sum2_temp := X"FFFFFFFF";
          ELSE 
            sum2_temp := add_temp_0(31 DOWNTO 0);
          END IF;
        END IF;
        add_temp_1 := resize(counter, 9) + to_unsigned(16#001#, 9);
        IF add_temp_1(8) /= '0' THEN 
          counter_temp := "11111111";
        ELSE 
          counter_temp := add_temp_1(7 DOWNTO 0);
        END IF;
        IF counter_temp > to_unsigned(16#00000010#, 8) THEN 
          -- Check header
          IF sum1_temp /= sum2_temp THEN 
            -- Fail
            packetLenBits_next <= to_unsigned(16#00000000#, 32);
            lastMode_next <= to_unsigned(16#03#, 8);
            resetViterbi <= '0';
            packetLenBitsOut_tmp <= to_unsigned(16#0000#, 16);
            savedPacketLenBits_next <= to_unsigned(16#0000#, 16);
            status_tmp <= to_unsigned(16#02#, 8);
            s1_tmp <= sum1_temp;
            s2_tmp <= sum2_temp;
          ELSE 
            -- Pass
            -- Saved header info and trigger downstream
            packetLenBits_next <= sum1_temp;
            lastMode_next <= to_unsigned(16#02#, 8);
            resetViterbi <= '1';
            sub_cast_2 := signed(resize(sum1_temp, 33));
            sub_temp_0 := sub_cast_2 - to_signed(218, 33);
            IF (sub_temp_0(32) = '0') AND (sub_temp_0(31 DOWNTO 16) /= X"0000") THEN 
              packetLenBitsOut_tmp <= X"FFFF";
            ELSIF sub_temp_0(32) = '1' THEN 
              packetLenBitsOut_tmp <= X"0000";
            ELSE 
              packetLenBitsOut_tmp <= unsigned(sub_temp_0(15 DOWNTO 0));
            END IF;
            sub_cast_3 := signed(resize(sum1_temp, 33));
            sub_temp_1 := sub_cast_3 - to_signed(218, 33);
            IF (sub_temp_1(32) = '0') AND (sub_temp_1(31 DOWNTO 16) /= X"0000") THEN 
              savedPacketLenBits_next <= X"FFFF";
            ELSIF sub_temp_1(32) = '1' THEN 
              savedPacketLenBits_next <= X"0000";
            ELSE 
              savedPacketLenBits_next <= unsigned(sub_temp_1(15 DOWNTO 0));
            END IF;
            status_tmp <= to_unsigned(16#01#, 8);
            s1_tmp <= sum1_temp;
            s2_tmp <= sum2_temp;
          END IF;
        ELSE 
          status_tmp <= to_unsigned(16#00#, 8);
          s1_tmp <= to_unsigned(16#00000000#, 32);
          s2_tmp <= to_unsigned(16#00000000#, 32);
          packetLenBitsOut_tmp <= to_unsigned(16#0000#, 16);
          resetViterbi <= '0';
        END IF;
        --    %% Decrement sample counter
      WHEN "00000010" =>
        status_tmp <= to_unsigned(16#00#, 8);
        s1_tmp <= to_unsigned(16#00000000#, 32);
        s2_tmp <= to_unsigned(16#00000000#, 32);
        resetViterbi <= '0';
        IF packetLenBits = to_unsigned(16#000000DA#, 32) THEN 
          crcStart <= '1';
        ELSE 
          crcStart <= '0';
        END IF;
        IF packetLenBits > to_unsigned(16#00000000#, 32) THEN 
          enableDownstream <= '1';
          sub_cast_1 := signed(resize(packetLenBits, 33));
          sub_temp := sub_cast_1 - to_signed(2, 33);
          IF sub_temp(32) = '1' THEN 
            packetLenBits_next <= X"00000000";
          ELSE 
            packetLenBits_next <= unsigned(sub_temp(31 DOWNTO 0));
          END IF;
          -- We get 2 bits each call
          packetLenBitsOut_tmp <= savedPacketLenBits;
        ELSE 
          enableDownstream <= '0';
          lastMode_next <= to_unsigned(16#03#, 8);
          packetLenBitsOut_tmp <= to_unsigned(16#0000#, 16);
          --Reset
          savedPacketLenBits_next <= to_unsigned(16#0000#, 16);
          --Reset
        END IF;
        --    %% Not processing anything
      WHEN OTHERS => 
        -- mode>2
        status_tmp <= to_unsigned(16#00#, 8);
        s1_tmp <= to_unsigned(16#00000000#, 32);
        s2_tmp <= to_unsigned(16#00000000#, 32);
        crcStart <= '0';
        resetViterbi <= '0';
        enableDownstream <= '0';
        packetLenBitsOut_tmp <= to_unsigned(16#0000#, 16);
    END CASE;
    counter_next <= counter_temp;
    sum1_next <= sum1_temp;
    sum2_next <= sum2_temp;
  END PROCESS RxTxFixedPointLibrary_c15_Header_Controller_output;


  packetLenBitsOut <= std_logic_vector(packetLenBitsOut_tmp);

  status <= std_logic_vector(status_tmp);

  s1 <= std_logic_vector(s1_tmp);

  s2 <= std_logic_vector(s2_tmp);

END rtl;

