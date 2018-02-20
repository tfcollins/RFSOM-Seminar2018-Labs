-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_ExternalMode\CombinedT_ip_src_PED.vhd
-- Created: 2018-02-01 13:20:09
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_PED
-- Source Path: combinedTxRx_ExternalMode/Combined TX and RX/Receiver HDL/Frame Recover/Frequency Recovery/PED
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CombinedT_ip_src_PED IS
  PORT( In_re                             :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        In_im                             :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        e                                 :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En10
        );
END CombinedT_ip_src_PED;


ARCHITECTURE rtl OF CombinedT_ip_src_PED IS

  -- Signals
  SIGNAL In_re_signed                     : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL In_im_signed                     : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL e_tmp                            : signed(15 DOWNTO 0);  -- sfix16_En10

BEGIN
  In_re_signed <= signed(In_re);

  In_im_signed <= signed(In_im);

  RxTxFixedPointLibrary_c16_PED_output : PROCESS (In_re_signed, In_im_signed)
    VARIABLE yfi : signed(15 DOWNTO 0);
    VARIABLE yfi_0 : signed(15 DOWNTO 0);
    VARIABLE cast : signed(16 DOWNTO 0);
    VARIABLE cast_0 : signed(16 DOWNTO 0);
    VARIABLE sub_cast : signed(16 DOWNTO 0);
    VARIABLE sub_cast_0 : signed(16 DOWNTO 0);
    VARIABLE sub_temp : signed(16 DOWNTO 0);
    VARIABLE cast_1 : signed(16 DOWNTO 0);
    VARIABLE cast_2 : signed(16 DOWNTO 0);
  BEGIN
    yfi_0 := In_re_signed;
    yfi := In_im_signed;
    IF In_re_signed(15) = '1' THEN 
      -- real component is negative
      cast := resize(In_im_signed, 17);
      cast_0 :=  - (cast);
      IF (cast_0(16) = '0') AND (cast_0(15) /= '0') THEN 
        yfi := X"7FFF";
      ELSIF (cast_0(16) = '1') AND (cast_0(15) /= '1') THEN 
        yfi := X"8000";
      ELSE 
        yfi := cast_0(15 DOWNTO 0);
      END IF;
    END IF;
    IF In_im_signed(15) = '1' THEN 
      -- imaginary component is negative
      cast_1 := resize(In_re_signed, 17);
      cast_2 :=  - (cast_1);
      IF (cast_2(16) = '0') AND (cast_2(15) /= '0') THEN 
        yfi_0 := X"7FFF";
      ELSIF (cast_2(16) = '1') AND (cast_2(15) /= '1') THEN 
        yfi_0 := X"8000";
      ELSE 
        yfi_0 := cast_2(15 DOWNTO 0);
      END IF;
    END IF;
    sub_cast := resize(yfi, 17);
    sub_cast_0 := resize(yfi_0, 17);
    sub_temp := sub_cast - sub_cast_0;
    e_tmp <= (resize(sub_temp(16 DOWNTO 3), 16)) + ('0' & sub_temp(2));
    --e = sign(real(In)).*imag(In) - sign(imag(In)).*real(In);
  END PROCESS RxTxFixedPointLibrary_c16_PED_output;


  e <= std_logic_vector(e_tmp);

END rtl;

