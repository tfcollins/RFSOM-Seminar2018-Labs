-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_StandardIQ\CombinedT_ip_src_Frame_Recover.vhd
-- Created: 2018-02-01 11:49:53
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_Frame_Recover
-- Source Path: combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Frame Recover
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_Frame_Recover IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        iqIn_re                           :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        iqIn_im                           :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        validIn                           :   IN    std_logic;
        FRLoopBW                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        EQmu                              :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
        ErrorSelector                     :   IN    std_logic_vector(7 DOWNTO 0);  -- int8
        validOut                          :   OUT   std_logic;
        frameStart                        :   OUT   std_logic;
        crcEnd                            :   OUT   std_logic;
        bitsOut                           :   OUT   std_logic_vector(0 TO 1);  -- boolean [2]
        packetLen                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        scopes_After_SRRC_signal1_re      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_SRRC_signal1_im      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_SRRC_signal2         :   OUT   std_logic;
        scopes_After_Timing_signal1_re    :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_Timing_signal1_im    :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_Timing_signal2       :   OUT   std_logic;
        scopes_After_Frequency_signal1_re :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_Frequency_signal1_im :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_Frequency_signal2    :   OUT   std_logic;
        scopes_After_EQ_signal1_re        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_EQ_signal1_im        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_After_EQ_signal2           :   OUT   std_logic;
        scopes_From_Radio_signal1_re      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_From_Radio_signal1_im      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        scopes_From_Radio_signal2         :   OUT   std_logic;
        SelectedError                     :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
        );
END CombinedT_ip_src_Frame_Recover;


ARCHITECTURE rtl OF CombinedT_ip_src_Frame_Recover IS

  -- Component Declarations
  COMPONENT CombinedT_ip_src_SRRC
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En11
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En11
          validIn                         :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En11
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En11
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Gardner_Timing_Recovery
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Enable                          :   IN    std_logic;
          Out1_re                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          Out1_im                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          strobe                          :   OUT   std_logic;
          lock                            :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Frequency_Recovery
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          validIn                         :   IN    std_logic;
          LoopBW                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          Enable                          :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          validOut                        :   OUT   std_logic;
          lock                            :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Barker_Locate
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          validIn                         :   IN    std_logic;
          Detector                        :   OUT   std_logic;
          validOut                        :   OUT   std_logic;
          Signal_re                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          Signal_im                       :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          start                           :   IN    std_logic;
          validIn                         :   IN    std_logic;
          enable                          :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Equalization_and_Demodulation
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Trigger                         :   IN    std_logic;
          Data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          Data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          EQmu                            :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          Enable                          :   IN    std_logic;
          AfterEQ_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          AfterEQ_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validOut                        :   OUT   std_logic;
          resetViterbi                    :   OUT   std_logic;
          crcEnd                          :   OUT   std_logic;
          dataOut                         :   OUT   std_logic_vector(0 TO 1);  -- boolean [2]
          packLen                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          HeaderDebug_status              :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          HeaderDebug_s1                  :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
          HeaderDebug_s2                  :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_Manage_Error_Signals
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ErrorSelector                   :   IN    std_logic_vector(7 DOWNTO 0);  -- int8
          In2                             :   IN    std_logic;
          Peak_Detector                   :   IN    std_logic_vector(0 TO 1);  -- boolean [2]
          FreqPLL_Lock                    :   IN    std_logic;
          Header_Debug_status             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          Header_Debug_s1                 :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          Header_Debug_s2                 :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          Out1                            :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_RM_Constellation_Diagram_After_Freq_Sync
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Enable                          :   IN    std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_RM_Constellation_Diagram_After_SRRC
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Enable                          :   IN    std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_RM_Constellation_Diagram_After_Timing
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En10
          Enable                          :   IN    std_logic
          );
  END COMPONENT;

  COMPONENT CombinedT_ip_src_RM_Spectrum_Plot_From_Radio
    PORT( In1_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          In1_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- int16
          Enable                          :   IN    std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : CombinedT_ip_src_SRRC
    USE ENTITY work.CombinedT_ip_src_SRRC(rtl);

  FOR ALL : CombinedT_ip_src_Gardner_Timing_Recovery
    USE ENTITY work.CombinedT_ip_src_Gardner_Timing_Recovery(rtl);

  FOR ALL : CombinedT_ip_src_Frequency_Recovery
    USE ENTITY work.CombinedT_ip_src_Frequency_Recovery(rtl);

  FOR ALL : CombinedT_ip_src_Barker_Locate
    USE ENTITY work.CombinedT_ip_src_Barker_Locate(rtl);

  FOR ALL : CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch
    USE ENTITY work.CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch(rtl);

  FOR ALL : CombinedT_ip_src_Equalization_and_Demodulation
    USE ENTITY work.CombinedT_ip_src_Equalization_and_Demodulation(rtl);

  FOR ALL : CombinedT_ip_src_Manage_Error_Signals
    USE ENTITY work.CombinedT_ip_src_Manage_Error_Signals(rtl);

  FOR ALL : CombinedT_ip_src_RM_Constellation_Diagram_After_Freq_Sync
    USE ENTITY work.CombinedT_ip_src_RM_Constellation_Diagram_After_Freq_Sync(rtl);

  FOR ALL : CombinedT_ip_src_RM_Constellation_Diagram_After_SRRC
    USE ENTITY work.CombinedT_ip_src_RM_Constellation_Diagram_After_SRRC(rtl);

  FOR ALL : CombinedT_ip_src_RM_Constellation_Diagram_After_Timing
    USE ENTITY work.CombinedT_ip_src_RM_Constellation_Diagram_After_Timing(rtl);

  FOR ALL : CombinedT_ip_src_RM_Spectrum_Plot_From_Radio
    USE ENTITY work.CombinedT_ip_src_RM_Spectrum_Plot_From_Radio(rtl);

  -- Signals
  SIGNAL iqIn_re_signed                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL iqIn_im_signed                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL Scale_Data_out1_re               : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL Scale_Data_out1_im               : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL SRRC_out1_re                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL SRRC_out1_im                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL SRRC_out2                        : std_logic;
  SIGNAL SRRC_out1_re_signed              : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL SRRC_out1_im_signed              : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL Data_Type_Conversion_out1_re     : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Type_Conversion_out1_im     : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Pipeline_Delay_out1_re           : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Pipeline_Delay_out1_im           : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Pipeline_Delay4_out1             : std_logic;
  SIGNAL Gardner_Timing_Recovery_out1_re  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Gardner_Timing_Recovery_out1_im  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Gardner_Timing_Recovery_out2     : std_logic;
  SIGNAL Gardner_Timing_Recovery_out3     : std_logic;
  SIGNAL Gardner_Timing_Recovery_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Gardner_Timing_Recovery_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Pipeline_Delay1_out1_re          : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Pipeline_Delay1_out1_im          : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL Pipeline_Delay2_out1             : std_logic;
  SIGNAL Frequency_Recovery_out1_re       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Frequency_Recovery_out1_im       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Frequency_Recovery_out2          : std_logic;
  SIGNAL Frequency_Recovery_out3          : std_logic;
  SIGNAL Frequency_Recovery_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Frequency_Recovery_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Pipeline_Delay3_out1_re          : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Pipeline_Delay3_out1_im          : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Pipeline_Delay5_out1             : std_logic;
  SIGNAL Barker_Locate_out1               : std_logic;
  SIGNAL Barker_Locate_out2               : std_logic;
  SIGNAL Barker_Locate_out3_re            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Barker_Locate_out3_im            : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Pipeline_Delay6_out1             : std_logic;
  SIGNAL Pipeline_Delay7_out1             : std_logic;
  SIGNAL enable                           : std_logic;
  SIGNAL enable_1                         : std_logic;
  SIGNAL Barker_Locate_out3_re_signed     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Barker_Locate_out3_im_signed     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Pipeline_Delay8_out1_re          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Pipeline_Delay8_out1_im          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Equalization_and_Demodulation_out1_re : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Equalization_and_Demodulation_out1_im : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Equalization_and_Demodulation_out2 : std_logic;
  SIGNAL Equalization_and_Demodulation_out3 : std_logic;
  SIGNAL Equalization_and_Demodulation_out4 : std_logic;
  SIGNAL Equalization_and_Demodulation_out5 : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Equalization_and_Demodulation_out6 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Equalization_and_Demodulation_out7_status : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL Equalization_and_Demodulation_out7_s1 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Equalization_and_Demodulation_out7_s2 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL After_SRRC_signal1_re            : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_SRRC_signal1_im            : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_SRRC_signal2               : std_logic;
  SIGNAL Data_Type_Conversion1_out1_re    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Type_Conversion1_out1_im    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_Timing_signal1_re          : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_Timing_signal1_im          : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_Timing_signal2             : std_logic;
  SIGNAL Data_Type_Conversion2_out1_re    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Type_Conversion2_out1_im    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_Frequency_signal1_re       : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_Frequency_signal1_im       : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL After_Frequency_signal2          : std_logic;
  SIGNAL Equalization_and_Demodulation_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Equalization_and_Demodulation_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Data_Type_Conversion4_out1_re    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Type_Conversion4_out1_im    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Type_Conversion3_out1_re    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Type_Conversion3_out1_im    : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL From_Radio_signal1_re            : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL From_Radio_signal1_im            : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL From_Radio_signal2               : std_logic;
  SIGNAL Mux_out1                         : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Manage_Error_Signals_out1        : std_logic_vector(31 DOWNTO 0);  -- ufix32

BEGIN
  u_SRRC : CombinedT_ip_src_SRRC
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn_re => std_logic_vector(Scale_Data_out1_re),  -- sfix16_En11
              dataIn_im => std_logic_vector(Scale_Data_out1_im),  -- sfix16_En11
              validIn => validIn,
              dataOut_re => SRRC_out1_re,  -- sfix16_En11
              dataOut_im => SRRC_out1_im,  -- sfix16_En11
              validOut => SRRC_out2
              );

  u_Gardner_Timing_Recovery : CombinedT_ip_src_Gardner_Timing_Recovery
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In1_re => std_logic_vector(Pipeline_Delay_out1_re),  -- sfix16_En13
              In1_im => std_logic_vector(Pipeline_Delay_out1_im),  -- sfix16_En13
              Enable => Pipeline_Delay4_out1,
              Out1_re => Gardner_Timing_Recovery_out1_re,  -- sfix16_En10
              Out1_im => Gardner_Timing_Recovery_out1_im,  -- sfix16_En10
              strobe => Gardner_Timing_Recovery_out2,
              lock => Gardner_Timing_Recovery_out3
              );

  u_Frequency_Recovery : CombinedT_ip_src_Frequency_Recovery
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn_re => std_logic_vector(Pipeline_Delay1_out1_re),  -- sfix16_En10
              dataIn_im => std_logic_vector(Pipeline_Delay1_out1_im),  -- sfix16_En10
              validIn => Pipeline_Delay2_out1,
              LoopBW => FRLoopBW,  -- int16
              Enable => Pipeline_Delay2_out1,
              dataOut_re => Frequency_Recovery_out1_re,  -- sfix16_En13
              dataOut_im => Frequency_Recovery_out1_im,  -- sfix16_En13
              validOut => Frequency_Recovery_out2,
              lock => Frequency_Recovery_out3
              );

  u_Barker_Locate : CombinedT_ip_src_Barker_Locate
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In1_re => std_logic_vector(Pipeline_Delay3_out1_re),  -- sfix16_En13
              In1_im => std_logic_vector(Pipeline_Delay3_out1_im),  -- sfix16_En13
              validIn => Pipeline_Delay5_out1,
              Detector => Barker_Locate_out1,
              validOut => Barker_Locate_out2,
              Signal_re => Barker_Locate_out3_re,  -- sfix16_En14
              Signal_im => Barker_Locate_out3_im  -- sfix16_En14
              );

  u_Enable_Equalizer_and_Packet_Decode_Latch : CombinedT_ip_src_Enable_Equalizer_and_Packet_Decode_Latch
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              start => Pipeline_Delay6_out1,
              validIn => Pipeline_Delay7_out1,
              enable => enable
              );

  u_Equalization_and_Demodulation : CombinedT_ip_src_Equalization_and_Demodulation
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              Trigger => Pipeline_Delay6_out1,
              Data_re => std_logic_vector(Pipeline_Delay8_out1_re),  -- sfix16_En14
              Data_im => std_logic_vector(Pipeline_Delay8_out1_im),  -- sfix16_En14
              EQmu => EQmu,  -- int16
              Enable => enable,
              AfterEQ_re => Equalization_and_Demodulation_out1_re,  -- sfix16_En14
              AfterEQ_im => Equalization_and_Demodulation_out1_im,  -- sfix16_En14
              validOut => Equalization_and_Demodulation_out2,
              resetViterbi => Equalization_and_Demodulation_out3,
              crcEnd => Equalization_and_Demodulation_out4,
              dataOut => Equalization_and_Demodulation_out5,  -- boolean [2]
              packLen => Equalization_and_Demodulation_out6,  -- uint16
              HeaderDebug_status => Equalization_and_Demodulation_out7_status,  -- uint8
              HeaderDebug_s1 => Equalization_and_Demodulation_out7_s1,  -- uint32
              HeaderDebug_s2 => Equalization_and_Demodulation_out7_s2  -- uint32
              );

  u_Manage_Error_Signals : CombinedT_ip_src_Manage_Error_Signals
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ErrorSelector => ErrorSelector,  -- int8
              In2 => Gardner_Timing_Recovery_out3,
              Peak_Detector => Mux_out1,  -- boolean [2]
              FreqPLL_Lock => Frequency_Recovery_out3,
              Header_Debug_status => Equalization_and_Demodulation_out7_status,  -- uint8
              Header_Debug_s1 => Equalization_and_Demodulation_out7_s1,  -- uint32
              Header_Debug_s2 => Equalization_and_Demodulation_out7_s2,  -- uint32
              Out1 => Manage_Error_Signals_out1  -- uint32
              );

  u_RM_Constellation_Diagram_After_Freq_Sync : CombinedT_ip_src_RM_Constellation_Diagram_After_Freq_Sync
    PORT MAP( In1_re => Frequency_Recovery_out1_re,  -- sfix16_En13
              In1_im => Frequency_Recovery_out1_im,  -- sfix16_En13
              Enable => Frequency_Recovery_out2
              );

  u_RM_Constellation_Diagram_After_SRRC : CombinedT_ip_src_RM_Constellation_Diagram_After_SRRC
    PORT MAP( In1_re => std_logic_vector(Data_Type_Conversion_out1_re),  -- sfix16_En13
              In1_im => std_logic_vector(Data_Type_Conversion_out1_im),  -- sfix16_En13
              Enable => SRRC_out2
              );

  u_RM_Constellation_Diagram_After_Timing : CombinedT_ip_src_RM_Constellation_Diagram_After_Timing
    PORT MAP( In1_re => Gardner_Timing_Recovery_out1_re,  -- sfix16_En10
              In1_im => Gardner_Timing_Recovery_out1_im,  -- sfix16_En10
              Enable => Gardner_Timing_Recovery_out2
              );

  u_RM_Spectrum_Plot_From_Radio : CombinedT_ip_src_RM_Spectrum_Plot_From_Radio
    PORT MAP( In1_re => iqIn_re,  -- int16
              In1_im => iqIn_im,  -- int16
              Enable => validIn
              );

  iqIn_re_signed <= signed(iqIn_re);

  iqIn_im_signed <= signed(iqIn_im);

  Scale_Data_out1_re <= iqIn_re_signed;
  Scale_Data_out1_im <= iqIn_im_signed;

  SRRC_out1_re_signed <= signed(SRRC_out1_re);

  SRRC_out1_im_signed <= signed(SRRC_out1_im);

  Data_Type_Conversion_out1_re <= SRRC_out1_re_signed(13 DOWNTO 0) & '0' & '0';
  Data_Type_Conversion_out1_im <= SRRC_out1_im_signed(13 DOWNTO 0) & '0' & '0';

  Pipeline_Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay_out1_re <= to_signed(16#0000#, 16);
      Pipeline_Delay_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay_out1_re <= Data_Type_Conversion_out1_re;
        Pipeline_Delay_out1_im <= Data_Type_Conversion_out1_im;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay_process;


  Pipeline_Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay4_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay4_out1 <= SRRC_out2;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay4_process;


  Gardner_Timing_Recovery_out1_re_signed <= signed(Gardner_Timing_Recovery_out1_re);

  Gardner_Timing_Recovery_out1_im_signed <= signed(Gardner_Timing_Recovery_out1_im);

  Pipeline_Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay1_out1_re <= to_signed(16#0000#, 16);
      Pipeline_Delay1_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay1_out1_re <= Gardner_Timing_Recovery_out1_re_signed;
        Pipeline_Delay1_out1_im <= Gardner_Timing_Recovery_out1_im_signed;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay1_process;


  Pipeline_Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay2_out1 <= Gardner_Timing_Recovery_out2;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay2_process;


  Frequency_Recovery_out1_re_signed <= signed(Frequency_Recovery_out1_re);

  Frequency_Recovery_out1_im_signed <= signed(Frequency_Recovery_out1_im);

  Pipeline_Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay3_out1_re <= to_signed(16#0000#, 16);
      Pipeline_Delay3_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay3_out1_re <= Frequency_Recovery_out1_re_signed;
        Pipeline_Delay3_out1_im <= Frequency_Recovery_out1_im_signed;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay3_process;


  Pipeline_Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay5_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay5_out1 <= Frequency_Recovery_out2;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay5_process;


  Pipeline_Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay6_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay6_out1 <= Barker_Locate_out1;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay6_process;


  Pipeline_Delay7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay7_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay7_out1 <= Barker_Locate_out2;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay7_process;


  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      enable_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        enable_1 <= enable;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  Barker_Locate_out3_re_signed <= signed(Barker_Locate_out3_re);

  Barker_Locate_out3_im_signed <= signed(Barker_Locate_out3_im);

  Pipeline_Delay8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Pipeline_Delay8_out1_re <= to_signed(16#0000#, 16);
      Pipeline_Delay8_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Pipeline_Delay8_out1_re <= Barker_Locate_out3_re_signed;
        Pipeline_Delay8_out1_im <= Barker_Locate_out3_im_signed;
      END IF;
    END IF;
  END PROCESS Pipeline_Delay8_process;


  Logical_Operator_out1 <= enable_1 AND Equalization_and_Demodulation_out2;

  c_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      After_SRRC_signal1_re <= to_signed(16#0000#, 16);
      After_SRRC_signal1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        After_SRRC_signal1_re <= Data_Type_Conversion_out1_re;
        After_SRRC_signal1_im <= Data_Type_Conversion_out1_im;
      END IF;
    END IF;
  END PROCESS c_process;


  scopes_After_SRRC_signal1_re <= std_logic_vector(After_SRRC_signal1_re);

  scopes_After_SRRC_signal1_im <= std_logic_vector(After_SRRC_signal1_im);

  c_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      After_SRRC_signal2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        After_SRRC_signal2 <= SRRC_out2;
      END IF;
    END IF;
  END PROCESS c_1_process;


  Data_Type_Conversion1_out1_re <= Gardner_Timing_Recovery_out1_re_signed(12 DOWNTO 0) & '0' & '0' & '0';
  Data_Type_Conversion1_out1_im <= Gardner_Timing_Recovery_out1_im_signed(12 DOWNTO 0) & '0' & '0' & '0';

  c_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      After_Timing_signal1_re <= to_signed(16#0000#, 16);
      After_Timing_signal1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        After_Timing_signal1_re <= Data_Type_Conversion1_out1_re;
        After_Timing_signal1_im <= Data_Type_Conversion1_out1_im;
      END IF;
    END IF;
  END PROCESS c_2_process;


  scopes_After_Timing_signal1_re <= std_logic_vector(After_Timing_signal1_re);

  scopes_After_Timing_signal1_im <= std_logic_vector(After_Timing_signal1_im);

  c_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      After_Timing_signal2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        After_Timing_signal2 <= Gardner_Timing_Recovery_out2;
      END IF;
    END IF;
  END PROCESS c_3_process;


  Data_Type_Conversion2_out1_re <= Frequency_Recovery_out1_re_signed;
  Data_Type_Conversion2_out1_im <= Frequency_Recovery_out1_im_signed;

  c_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      After_Frequency_signal1_re <= to_signed(16#0000#, 16);
      After_Frequency_signal1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        After_Frequency_signal1_re <= Data_Type_Conversion2_out1_re;
        After_Frequency_signal1_im <= Data_Type_Conversion2_out1_im;
      END IF;
    END IF;
  END PROCESS c_4_process;


  scopes_After_Frequency_signal1_re <= std_logic_vector(After_Frequency_signal1_re);

  scopes_After_Frequency_signal1_im <= std_logic_vector(After_Frequency_signal1_im);

  c_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      After_Frequency_signal2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        After_Frequency_signal2 <= Frequency_Recovery_out2;
      END IF;
    END IF;
  END PROCESS c_5_process;


  Equalization_and_Demodulation_out1_re_signed <= signed(Equalization_and_Demodulation_out1_re);

  Equalization_and_Demodulation_out1_im_signed <= signed(Equalization_and_Demodulation_out1_im);

  Data_Type_Conversion4_out1_re <= resize(Equalization_and_Demodulation_out1_re_signed(15 DOWNTO 1), 16);
  Data_Type_Conversion4_out1_im <= resize(Equalization_and_Demodulation_out1_im_signed(15 DOWNTO 1), 16);

  scopes_After_EQ_signal1_re <= std_logic_vector(Data_Type_Conversion4_out1_re);

  scopes_After_EQ_signal1_im <= std_logic_vector(Data_Type_Conversion4_out1_im);

  Data_Type_Conversion3_out1_re <= iqIn_re_signed(2 DOWNTO 0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
  Data_Type_Conversion3_out1_im <= iqIn_im_signed(2 DOWNTO 0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';

  c_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      From_Radio_signal1_re <= to_signed(16#0000#, 16);
      From_Radio_signal1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        From_Radio_signal1_re <= Data_Type_Conversion3_out1_re;
        From_Radio_signal1_im <= Data_Type_Conversion3_out1_im;
      END IF;
    END IF;
  END PROCESS c_6_process;


  scopes_From_Radio_signal1_re <= std_logic_vector(From_Radio_signal1_re);

  scopes_From_Radio_signal1_im <= std_logic_vector(From_Radio_signal1_im);

  c_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      From_Radio_signal2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        From_Radio_signal2 <= validIn;
      END IF;
    END IF;
  END PROCESS c_7_process;


  Mux_out1(0) <= Barker_Locate_out2;
  Mux_out1(1) <= Barker_Locate_out1;

  validOut <= Logical_Operator_out1;

  frameStart <= Equalization_and_Demodulation_out3;

  crcEnd <= Equalization_and_Demodulation_out4;

  bitsOut <= Equalization_and_Demodulation_out5;

  packetLen <= Equalization_and_Demodulation_out6;

  scopes_After_SRRC_signal2 <= After_SRRC_signal2;

  scopes_After_Timing_signal2 <= After_Timing_signal2;

  scopes_After_Frequency_signal2 <= After_Frequency_signal2;

  scopes_After_EQ_signal2 <= Logical_Operator_out1;

  scopes_From_Radio_signal2 <= From_Radio_signal2;

  SelectedError <= Manage_Error_Signals_out1;

END rtl;

