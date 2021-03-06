-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_AXIMM\CombinedT_ip_addr_decoder.vhd
-- Created: 2018-02-01 18:12:14
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_addr_decoder
-- Source Path: CombinedT_ip/CombinedT_ip_axi_lite/CombinedT_ip_addr_decoder
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_addr_decoder IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        data_write                        :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        addr_sel                          :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14
        wr_enb                            :   IN    std_logic;  -- ufix1
        rd_enb                            :   IN    std_logic;  -- ufix1
        read_ip_timestamp                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        read_packetCount                  :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        read_selectedError                :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        read_packetLen                    :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        data_read                         :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_axi_enable                  :   OUT   std_logic;  -- ufix1
        write_LoopBW                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16
        write_EQmu                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16
        write_SelectScope                 :   OUT   std_logic_vector(7 DOWNTO 0);  -- sfix8
        write_SelectError                 :   OUT   std_logic_vector(7 DOWNTO 0)  -- sfix8
        );
END CombinedT_ip_addr_decoder;


ARCHITECTURE rtl OF CombinedT_ip_addr_decoder IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL addr_sel_unsigned                : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL decode_sel_ip_timestamp          : std_logic;  -- ufix1
  SIGNAL read_ip_timestamp_unsigned       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL const_1                          : std_logic;  -- ufix1
  SIGNAL read_packetCount_unsigned        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_selectedError_unsigned      : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_packetLen_unsigned          : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL decode_sel_packetLen             : std_logic;  -- ufix1
  SIGNAL decode_sel_selectedError         : std_logic;  -- ufix1
  SIGNAL decode_sel_packetCount           : std_logic;  -- ufix1
  SIGNAL const_0                          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_ip_timestamp            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_ip_timestamp           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_packetCount             : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_packetCount            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_selectedError           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_selectedError          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_packetLen               : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL data_in_packetLen                : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_packetLen              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_sel_axi_enable            : std_logic;  -- ufix1
  SIGNAL reg_enb_axi_enable               : std_logic;  -- ufix1
  SIGNAL data_write_unsigned              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL data_in_axi_enable               : std_logic;  -- ufix1
  SIGNAL write_reg_axi_enable             : std_logic;  -- ufix1
  SIGNAL decode_sel_LoopBW                : std_logic;  -- ufix1
  SIGNAL reg_enb_LoopBW                   : std_logic;  -- ufix1
  SIGNAL data_in_LoopBW                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL write_reg_LoopBW                 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL decode_sel_EQmu                  : std_logic;  -- ufix1
  SIGNAL reg_enb_EQmu                     : std_logic;  -- ufix1
  SIGNAL data_in_EQmu                     : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL write_reg_EQmu                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL decode_sel_SelectScope           : std_logic;  -- ufix1
  SIGNAL reg_enb_SelectScope              : std_logic;  -- ufix1
  SIGNAL data_in_SelectScope              : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL write_reg_SelectScope            : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL decode_sel_SelectError           : std_logic;  -- ufix1
  SIGNAL reg_enb_SelectError              : std_logic;  -- ufix1
  SIGNAL data_in_SelectError              : signed(7 DOWNTO 0);  -- sfix8
  SIGNAL write_reg_SelectError            : signed(7 DOWNTO 0);  -- sfix8

BEGIN
  addr_sel_unsigned <= unsigned(addr_sel);

  
  decode_sel_ip_timestamp <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0002#, 14) ELSE
      '0';

  read_ip_timestamp_unsigned <= unsigned(read_ip_timestamp);

  const_1 <= '1';

  enb <= const_1;

  read_packetCount_unsigned <= unsigned(read_packetCount);

  read_selectedError_unsigned <= unsigned(read_selectedError);

  read_packetLen_unsigned <= unsigned(read_packetLen);

  
  decode_sel_packetLen <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0046#, 14) ELSE
      '0';

  
  decode_sel_selectedError <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0045#, 14) ELSE
      '0';

  
  decode_sel_packetCount <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0044#, 14) ELSE
      '0';

  const_0 <= to_unsigned(0, 32);

  reg_ip_timestamp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_ip_timestamp <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_ip_timestamp <= read_ip_timestamp_unsigned;
      END IF;
    END IF;
  END PROCESS reg_ip_timestamp_process;


  
  decode_rd_ip_timestamp <= const_0 WHEN decode_sel_ip_timestamp = '0' ELSE
      read_reg_ip_timestamp;

  reg_packetCount_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_packetCount <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_packetCount <= read_packetCount_unsigned;
      END IF;
    END IF;
  END PROCESS reg_packetCount_process;


  
  decode_rd_packetCount <= decode_rd_ip_timestamp WHEN decode_sel_packetCount = '0' ELSE
      read_reg_packetCount;

  reg_selectedError_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_selectedError <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_selectedError <= read_selectedError_unsigned;
      END IF;
    END IF;
  END PROCESS reg_selectedError_process;


  
  decode_rd_selectedError <= decode_rd_packetCount WHEN decode_sel_selectedError = '0' ELSE
      read_reg_selectedError;

  reg_packetLen_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_packetLen <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_packetLen <= read_packetLen_unsigned;
      END IF;
    END IF;
  END PROCESS reg_packetLen_process;


  data_in_packetLen <= resize(read_reg_packetLen, 32);

  
  decode_rd_packetLen <= decode_rd_selectedError WHEN decode_sel_packetLen = '0' ELSE
      data_in_packetLen;

  data_read <= std_logic_vector(decode_rd_packetLen);

  
  decode_sel_axi_enable <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0001#, 14) ELSE
      '0';

  reg_enb_axi_enable <= decode_sel_axi_enable AND wr_enb;

  data_write_unsigned <= unsigned(data_write);

  data_in_axi_enable <= data_write_unsigned(0);

  reg_axi_enable_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_axi_enable <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_axi_enable = '1' THEN
        write_reg_axi_enable <= data_in_axi_enable;
      END IF;
    END IF;
  END PROCESS reg_axi_enable_process;


  write_axi_enable <= write_reg_axi_enable;

  
  decode_sel_LoopBW <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0040#, 14) ELSE
      '0';

  reg_enb_LoopBW <= decode_sel_LoopBW AND wr_enb;

  data_in_LoopBW <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_LoopBW_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_LoopBW <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_LoopBW = '1' THEN
        write_reg_LoopBW <= data_in_LoopBW;
      END IF;
    END IF;
  END PROCESS reg_LoopBW_process;


  write_LoopBW <= std_logic_vector(write_reg_LoopBW);

  
  decode_sel_EQmu <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0041#, 14) ELSE
      '0';

  reg_enb_EQmu <= decode_sel_EQmu AND wr_enb;

  data_in_EQmu <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_EQmu_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_EQmu <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_EQmu = '1' THEN
        write_reg_EQmu <= data_in_EQmu;
      END IF;
    END IF;
  END PROCESS reg_EQmu_process;


  write_EQmu <= std_logic_vector(write_reg_EQmu);

  
  decode_sel_SelectScope <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0042#, 14) ELSE
      '0';

  reg_enb_SelectScope <= decode_sel_SelectScope AND wr_enb;

  data_in_SelectScope <= signed(data_write_unsigned(7 DOWNTO 0));

  reg_SelectScope_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_SelectScope <= to_signed(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_SelectScope = '1' THEN
        write_reg_SelectScope <= data_in_SelectScope;
      END IF;
    END IF;
  END PROCESS reg_SelectScope_process;


  write_SelectScope <= std_logic_vector(write_reg_SelectScope);

  
  decode_sel_SelectError <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0043#, 14) ELSE
      '0';

  reg_enb_SelectError <= decode_sel_SelectError AND wr_enb;

  data_in_SelectError <= signed(data_write_unsigned(7 DOWNTO 0));

  reg_SelectError_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_SelectError <= to_signed(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_SelectError = '1' THEN
        write_reg_SelectError <= data_in_SelectError;
      END IF;
    END IF;
  END PROCESS reg_SelectError_process;


  write_SelectError <= std_logic_vector(write_reg_SelectError);

END rtl;

