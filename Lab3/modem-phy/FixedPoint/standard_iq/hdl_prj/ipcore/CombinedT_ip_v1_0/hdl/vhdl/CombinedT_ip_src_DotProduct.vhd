-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\combinedTxRx_StandardIQ\CombinedT_ip_src_DotProduct.vhd
-- Created: 2018-02-01 11:49:52
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: CombinedT_ip_src_DotProduct
-- Source Path: combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Frame Recover/Equalization and Demodulation/DFE/DFE/DotProduct
-- Hierarchy Level: 6
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.CombinedT_ip_src_Combined_TX_and_RX_pkg.ALL;

ENTITY CombinedT_ip_src_DotProduct IS
  PORT( in1_re                            :   IN    vector_of_std_logic_vector16(0 TO 2);  -- sfix16_En15 [3]
        in1_im                            :   IN    vector_of_std_logic_vector16(0 TO 2);  -- sfix16_En15 [3]
        in2_re                            :   IN    vector_of_std_logic_vector16(0 TO 2);  -- sfix16_En15 [3]
        in2_im                            :   IN    vector_of_std_logic_vector16(0 TO 2);  -- sfix16_En15 [3]
        out1_re                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En18
        out1_im                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En18
        );
END CombinedT_ip_src_DotProduct;


ARCHITECTURE rtl OF CombinedT_ip_src_DotProduct IS

  -- Signals
  SIGNAL in1_re_signed                    : vector_of_signed16(0 TO 2);  -- sfix16_En15 [3]
  SIGNAL in1_im_signed                    : vector_of_signed16(0 TO 2);  -- sfix16_En15 [3]
  SIGNAL conj_cast                        : vector_of_signed17(0 TO 2);  -- sfix17_En15 [3]
  SIGNAL conj_cast_1                      : vector_of_signed17(0 TO 2);  -- sfix17_En15 [3]
  SIGNAL cconj_Dot_Product1_dotp_re       : vector_of_signed16(0 TO 2);  -- sfix16_En15 [3]
  SIGNAL cconj_Dot_Product1_dotp_im       : vector_of_signed16(0 TO 2);  -- sfix16_En15 [3]
  SIGNAL cconj_Dot_Product1_dotp_2_re     : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL cconj_Dot_Product1_dotp_2_im     : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL in2_2_re                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL in2_2_im                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL mul_Dot_Product1_dotp_2_mul_temp : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_2_sub_cast : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_2_sub_cast_1 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_2_mul_temp_1 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_2_sub_cast_2 : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_2_sub_cast_3 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_2_sub_temp : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_2_mul_temp_2 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_2_add_cast : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_2_add_cast_1 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_2_mul_temp_3 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_2_add_cast_2 : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_2_add_cast_3 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_2_add_temp : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL tmp_Dot_Product1_dotp_2_re       : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL tmp_Dot_Product1_dotp_2_im       : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL cconj_Dot_Product1_dotp_1_re     : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL cconj_Dot_Product1_dotp_1_im     : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL in2_1_re                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL in2_1_im                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL mul_Dot_Product1_dotp_1_mul_temp : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_1_sub_cast : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_1_sub_cast_1 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_1_mul_temp_1 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_1_sub_cast_2 : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_1_sub_cast_3 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_1_sub_temp : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_1_mul_temp_2 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_1_add_cast : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_1_add_cast_1 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_1_mul_temp_3 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_1_add_cast_2 : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_1_add_cast_3 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_1_add_temp : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL tmp_Dot_Product1_dotp_1_re       : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL tmp_Dot_Product1_dotp_1_im       : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL cconj_Dot_Product1_dotp_0_re     : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL cconj_Dot_Product1_dotp_0_im     : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL in2_0_re                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL in2_0_im                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL mul_Dot_Product1_dotp_0_mul_temp : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_0_sub_cast : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_0_sub_cast_1 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_0_mul_temp_1 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_0_sub_cast_2 : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_0_sub_cast_3 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_0_sub_temp : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_0_mul_temp_2 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_0_add_cast : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_0_add_cast_1 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_0_mul_temp_3 : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL mul_Dot_Product1_dotp_0_add_cast_2 : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL mul_Dot_Product1_dotp_0_add_cast_3 : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL mul_Dot_Product1_dotp_0_add_temp : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL tmp_Dot_Product1_dotp_0_re       : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL tmp_Dot_Product1_dotp_0_im       : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL Dot_Product11_add_cast           : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product11_add_cast_1         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product11_add_temp           : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product11_add_cast_2         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product11_add_cast_3         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product11_add_temp_1         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL accsig_Dot_Product1_dotp_1_re    : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL accsig_Dot_Product1_dotp_1_im    : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL Dot_Product12_add_cast           : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product12_add_cast_1         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product12_add_temp           : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product12_add_cast_2         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product12_add_cast_3         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL Dot_Product12_add_temp_1         : signed(16 DOWNTO 0);  -- sfix17_En18
  SIGNAL out1_re_tmp                      : signed(15 DOWNTO 0);  -- sfix16_En18
  SIGNAL out1_im_tmp                      : signed(15 DOWNTO 0);  -- sfix16_En18

BEGIN
  outputgen1: FOR k IN 0 TO 2 GENERATE
    in1_re_signed(k) <= signed(in1_re(k));
  END GENERATE;

  outputgen: FOR k IN 0 TO 2 GENERATE
    in1_im_signed(k) <= signed(in1_im(k));
  END GENERATE;


  cconj_Dot_Product1_dotp_im_gen: FOR t_0 IN 0 TO 2 GENERATE
    cconj_Dot_Product1_dotp_re(t_0) <= in1_re_signed(t_0);
    conj_cast(t_0) <= resize(in1_im_signed(t_0), 17);
    conj_cast_1(t_0) <=  - (conj_cast(t_0));
    
    cconj_Dot_Product1_dotp_im(t_0) <= X"7FFF" WHEN (conj_cast_1(t_0)(16) = '0') AND (conj_cast_1(t_0)(15) /= '0') ELSE
        X"8000" WHEN (conj_cast_1(t_0)(16) = '1') AND (conj_cast_1(t_0)(15) /= '1') ELSE
        conj_cast_1(t_0)(15 DOWNTO 0);
  END GENERATE cconj_Dot_Product1_dotp_im_gen;


  cconj_Dot_Product1_dotp_2_re <= cconj_Dot_Product1_dotp_re(2);

  cconj_Dot_Product1_dotp_2_im <= cconj_Dot_Product1_dotp_im(2);

  in2_2_re <= signed(in2_re(2));

  in2_2_im <= signed(in2_im(2));

  mul_Dot_Product1_dotp_2_mul_temp <= cconj_Dot_Product1_dotp_2_re * in2_2_re;
  
  mul_Dot_Product1_dotp_2_sub_cast <= X"7FFF" WHEN (mul_Dot_Product1_dotp_2_mul_temp(31) = '0') AND (mul_Dot_Product1_dotp_2_mul_temp(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_2_mul_temp(31) = '1') AND (mul_Dot_Product1_dotp_2_mul_temp(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_2_mul_temp(27 DOWNTO 12);
  mul_Dot_Product1_dotp_2_sub_cast_1 <= resize(mul_Dot_Product1_dotp_2_sub_cast, 17);
  mul_Dot_Product1_dotp_2_mul_temp_1 <= cconj_Dot_Product1_dotp_2_im * in2_2_im;
  
  mul_Dot_Product1_dotp_2_sub_cast_2 <= X"7FFF" WHEN (mul_Dot_Product1_dotp_2_mul_temp_1(31) = '0') AND (mul_Dot_Product1_dotp_2_mul_temp_1(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_2_mul_temp_1(31) = '1') AND (mul_Dot_Product1_dotp_2_mul_temp_1(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_2_mul_temp_1(27 DOWNTO 12);
  mul_Dot_Product1_dotp_2_sub_cast_3 <= resize(mul_Dot_Product1_dotp_2_sub_cast_2, 17);
  mul_Dot_Product1_dotp_2_sub_temp <= mul_Dot_Product1_dotp_2_sub_cast_1 - mul_Dot_Product1_dotp_2_sub_cast_3;
  
  tmp_Dot_Product1_dotp_2_re <= X"7FFF" WHEN (mul_Dot_Product1_dotp_2_sub_temp(16) = '0') AND (mul_Dot_Product1_dotp_2_sub_temp(15) /= '0') ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_2_sub_temp(16) = '1') AND (mul_Dot_Product1_dotp_2_sub_temp(15) /= '1') ELSE
      mul_Dot_Product1_dotp_2_sub_temp(15 DOWNTO 0);
  mul_Dot_Product1_dotp_2_mul_temp_2 <= cconj_Dot_Product1_dotp_2_im * in2_2_re;
  
  mul_Dot_Product1_dotp_2_add_cast <= X"7FFF" WHEN (mul_Dot_Product1_dotp_2_mul_temp_2(31) = '0') AND (mul_Dot_Product1_dotp_2_mul_temp_2(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_2_mul_temp_2(31) = '1') AND (mul_Dot_Product1_dotp_2_mul_temp_2(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_2_mul_temp_2(27 DOWNTO 12);
  mul_Dot_Product1_dotp_2_add_cast_1 <= resize(mul_Dot_Product1_dotp_2_add_cast, 17);
  mul_Dot_Product1_dotp_2_mul_temp_3 <= cconj_Dot_Product1_dotp_2_re * in2_2_im;
  
  mul_Dot_Product1_dotp_2_add_cast_2 <= X"7FFF" WHEN (mul_Dot_Product1_dotp_2_mul_temp_3(31) = '0') AND (mul_Dot_Product1_dotp_2_mul_temp_3(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_2_mul_temp_3(31) = '1') AND (mul_Dot_Product1_dotp_2_mul_temp_3(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_2_mul_temp_3(27 DOWNTO 12);
  mul_Dot_Product1_dotp_2_add_cast_3 <= resize(mul_Dot_Product1_dotp_2_add_cast_2, 17);
  mul_Dot_Product1_dotp_2_add_temp <= mul_Dot_Product1_dotp_2_add_cast_1 + mul_Dot_Product1_dotp_2_add_cast_3;
  
  tmp_Dot_Product1_dotp_2_im <= X"7FFF" WHEN (mul_Dot_Product1_dotp_2_add_temp(16) = '0') AND (mul_Dot_Product1_dotp_2_add_temp(15) /= '0') ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_2_add_temp(16) = '1') AND (mul_Dot_Product1_dotp_2_add_temp(15) /= '1') ELSE
      mul_Dot_Product1_dotp_2_add_temp(15 DOWNTO 0);

  cconj_Dot_Product1_dotp_1_re <= cconj_Dot_Product1_dotp_re(1);

  cconj_Dot_Product1_dotp_1_im <= cconj_Dot_Product1_dotp_im(1);

  in2_1_re <= signed(in2_re(1));

  in2_1_im <= signed(in2_im(1));

  mul_Dot_Product1_dotp_1_mul_temp <= cconj_Dot_Product1_dotp_1_re * in2_1_re;
  
  mul_Dot_Product1_dotp_1_sub_cast <= X"7FFF" WHEN (mul_Dot_Product1_dotp_1_mul_temp(31) = '0') AND (mul_Dot_Product1_dotp_1_mul_temp(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_1_mul_temp(31) = '1') AND (mul_Dot_Product1_dotp_1_mul_temp(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_1_mul_temp(27 DOWNTO 12);
  mul_Dot_Product1_dotp_1_sub_cast_1 <= resize(mul_Dot_Product1_dotp_1_sub_cast, 17);
  mul_Dot_Product1_dotp_1_mul_temp_1 <= cconj_Dot_Product1_dotp_1_im * in2_1_im;
  
  mul_Dot_Product1_dotp_1_sub_cast_2 <= X"7FFF" WHEN (mul_Dot_Product1_dotp_1_mul_temp_1(31) = '0') AND (mul_Dot_Product1_dotp_1_mul_temp_1(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_1_mul_temp_1(31) = '1') AND (mul_Dot_Product1_dotp_1_mul_temp_1(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_1_mul_temp_1(27 DOWNTO 12);
  mul_Dot_Product1_dotp_1_sub_cast_3 <= resize(mul_Dot_Product1_dotp_1_sub_cast_2, 17);
  mul_Dot_Product1_dotp_1_sub_temp <= mul_Dot_Product1_dotp_1_sub_cast_1 - mul_Dot_Product1_dotp_1_sub_cast_3;
  
  tmp_Dot_Product1_dotp_1_re <= X"7FFF" WHEN (mul_Dot_Product1_dotp_1_sub_temp(16) = '0') AND (mul_Dot_Product1_dotp_1_sub_temp(15) /= '0') ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_1_sub_temp(16) = '1') AND (mul_Dot_Product1_dotp_1_sub_temp(15) /= '1') ELSE
      mul_Dot_Product1_dotp_1_sub_temp(15 DOWNTO 0);
  mul_Dot_Product1_dotp_1_mul_temp_2 <= cconj_Dot_Product1_dotp_1_im * in2_1_re;
  
  mul_Dot_Product1_dotp_1_add_cast <= X"7FFF" WHEN (mul_Dot_Product1_dotp_1_mul_temp_2(31) = '0') AND (mul_Dot_Product1_dotp_1_mul_temp_2(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_1_mul_temp_2(31) = '1') AND (mul_Dot_Product1_dotp_1_mul_temp_2(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_1_mul_temp_2(27 DOWNTO 12);
  mul_Dot_Product1_dotp_1_add_cast_1 <= resize(mul_Dot_Product1_dotp_1_add_cast, 17);
  mul_Dot_Product1_dotp_1_mul_temp_3 <= cconj_Dot_Product1_dotp_1_re * in2_1_im;
  
  mul_Dot_Product1_dotp_1_add_cast_2 <= X"7FFF" WHEN (mul_Dot_Product1_dotp_1_mul_temp_3(31) = '0') AND (mul_Dot_Product1_dotp_1_mul_temp_3(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_1_mul_temp_3(31) = '1') AND (mul_Dot_Product1_dotp_1_mul_temp_3(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_1_mul_temp_3(27 DOWNTO 12);
  mul_Dot_Product1_dotp_1_add_cast_3 <= resize(mul_Dot_Product1_dotp_1_add_cast_2, 17);
  mul_Dot_Product1_dotp_1_add_temp <= mul_Dot_Product1_dotp_1_add_cast_1 + mul_Dot_Product1_dotp_1_add_cast_3;
  
  tmp_Dot_Product1_dotp_1_im <= X"7FFF" WHEN (mul_Dot_Product1_dotp_1_add_temp(16) = '0') AND (mul_Dot_Product1_dotp_1_add_temp(15) /= '0') ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_1_add_temp(16) = '1') AND (mul_Dot_Product1_dotp_1_add_temp(15) /= '1') ELSE
      mul_Dot_Product1_dotp_1_add_temp(15 DOWNTO 0);

  cconj_Dot_Product1_dotp_0_re <= cconj_Dot_Product1_dotp_re(0);

  cconj_Dot_Product1_dotp_0_im <= cconj_Dot_Product1_dotp_im(0);

  in2_0_re <= signed(in2_re(0));

  in2_0_im <= signed(in2_im(0));

  mul_Dot_Product1_dotp_0_mul_temp <= cconj_Dot_Product1_dotp_0_re * in2_0_re;
  
  mul_Dot_Product1_dotp_0_sub_cast <= X"7FFF" WHEN (mul_Dot_Product1_dotp_0_mul_temp(31) = '0') AND (mul_Dot_Product1_dotp_0_mul_temp(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_0_mul_temp(31) = '1') AND (mul_Dot_Product1_dotp_0_mul_temp(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_0_mul_temp(27 DOWNTO 12);
  mul_Dot_Product1_dotp_0_sub_cast_1 <= resize(mul_Dot_Product1_dotp_0_sub_cast, 17);
  mul_Dot_Product1_dotp_0_mul_temp_1 <= cconj_Dot_Product1_dotp_0_im * in2_0_im;
  
  mul_Dot_Product1_dotp_0_sub_cast_2 <= X"7FFF" WHEN (mul_Dot_Product1_dotp_0_mul_temp_1(31) = '0') AND (mul_Dot_Product1_dotp_0_mul_temp_1(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_0_mul_temp_1(31) = '1') AND (mul_Dot_Product1_dotp_0_mul_temp_1(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_0_mul_temp_1(27 DOWNTO 12);
  mul_Dot_Product1_dotp_0_sub_cast_3 <= resize(mul_Dot_Product1_dotp_0_sub_cast_2, 17);
  mul_Dot_Product1_dotp_0_sub_temp <= mul_Dot_Product1_dotp_0_sub_cast_1 - mul_Dot_Product1_dotp_0_sub_cast_3;
  
  tmp_Dot_Product1_dotp_0_re <= X"7FFF" WHEN (mul_Dot_Product1_dotp_0_sub_temp(16) = '0') AND (mul_Dot_Product1_dotp_0_sub_temp(15) /= '0') ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_0_sub_temp(16) = '1') AND (mul_Dot_Product1_dotp_0_sub_temp(15) /= '1') ELSE
      mul_Dot_Product1_dotp_0_sub_temp(15 DOWNTO 0);
  mul_Dot_Product1_dotp_0_mul_temp_2 <= cconj_Dot_Product1_dotp_0_im * in2_0_re;
  
  mul_Dot_Product1_dotp_0_add_cast <= X"7FFF" WHEN (mul_Dot_Product1_dotp_0_mul_temp_2(31) = '0') AND (mul_Dot_Product1_dotp_0_mul_temp_2(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_0_mul_temp_2(31) = '1') AND (mul_Dot_Product1_dotp_0_mul_temp_2(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_0_mul_temp_2(27 DOWNTO 12);
  mul_Dot_Product1_dotp_0_add_cast_1 <= resize(mul_Dot_Product1_dotp_0_add_cast, 17);
  mul_Dot_Product1_dotp_0_mul_temp_3 <= cconj_Dot_Product1_dotp_0_re * in2_0_im;
  
  mul_Dot_Product1_dotp_0_add_cast_2 <= X"7FFF" WHEN (mul_Dot_Product1_dotp_0_mul_temp_3(31) = '0') AND (mul_Dot_Product1_dotp_0_mul_temp_3(30 DOWNTO 27) /= "0000") ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_0_mul_temp_3(31) = '1') AND (mul_Dot_Product1_dotp_0_mul_temp_3(30 DOWNTO 27) /= "1111") ELSE
      mul_Dot_Product1_dotp_0_mul_temp_3(27 DOWNTO 12);
  mul_Dot_Product1_dotp_0_add_cast_3 <= resize(mul_Dot_Product1_dotp_0_add_cast_2, 17);
  mul_Dot_Product1_dotp_0_add_temp <= mul_Dot_Product1_dotp_0_add_cast_1 + mul_Dot_Product1_dotp_0_add_cast_3;
  
  tmp_Dot_Product1_dotp_0_im <= X"7FFF" WHEN (mul_Dot_Product1_dotp_0_add_temp(16) = '0') AND (mul_Dot_Product1_dotp_0_add_temp(15) /= '0') ELSE
      X"8000" WHEN (mul_Dot_Product1_dotp_0_add_temp(16) = '1') AND (mul_Dot_Product1_dotp_0_add_temp(15) /= '1') ELSE
      mul_Dot_Product1_dotp_0_add_temp(15 DOWNTO 0);

  Dot_Product11_add_cast <= resize(tmp_Dot_Product1_dotp_1_re, 17);
  Dot_Product11_add_cast_1 <= resize(tmp_Dot_Product1_dotp_0_re, 17);
  Dot_Product11_add_temp <= Dot_Product11_add_cast + Dot_Product11_add_cast_1;
  
  accsig_Dot_Product1_dotp_1_re <= X"7FFF" WHEN (Dot_Product11_add_temp(16) = '0') AND (Dot_Product11_add_temp(15) /= '0') ELSE
      X"8000" WHEN (Dot_Product11_add_temp(16) = '1') AND (Dot_Product11_add_temp(15) /= '1') ELSE
      Dot_Product11_add_temp(15 DOWNTO 0);
  Dot_Product11_add_cast_2 <= resize(tmp_Dot_Product1_dotp_1_im, 17);
  Dot_Product11_add_cast_3 <= resize(tmp_Dot_Product1_dotp_0_im, 17);
  Dot_Product11_add_temp_1 <= Dot_Product11_add_cast_2 + Dot_Product11_add_cast_3;
  
  accsig_Dot_Product1_dotp_1_im <= X"7FFF" WHEN (Dot_Product11_add_temp_1(16) = '0') AND (Dot_Product11_add_temp_1(15) /= '0') ELSE
      X"8000" WHEN (Dot_Product11_add_temp_1(16) = '1') AND (Dot_Product11_add_temp_1(15) /= '1') ELSE
      Dot_Product11_add_temp_1(15 DOWNTO 0);

  Dot_Product12_add_cast <= resize(tmp_Dot_Product1_dotp_2_re, 17);
  Dot_Product12_add_cast_1 <= resize(accsig_Dot_Product1_dotp_1_re, 17);
  Dot_Product12_add_temp <= Dot_Product12_add_cast + Dot_Product12_add_cast_1;
  
  out1_re_tmp <= X"7FFF" WHEN (Dot_Product12_add_temp(16) = '0') AND (Dot_Product12_add_temp(15) /= '0') ELSE
      X"8000" WHEN (Dot_Product12_add_temp(16) = '1') AND (Dot_Product12_add_temp(15) /= '1') ELSE
      Dot_Product12_add_temp(15 DOWNTO 0);
  Dot_Product12_add_cast_2 <= resize(tmp_Dot_Product1_dotp_2_im, 17);
  Dot_Product12_add_cast_3 <= resize(accsig_Dot_Product1_dotp_1_im, 17);
  Dot_Product12_add_temp_1 <= Dot_Product12_add_cast_2 + Dot_Product12_add_cast_3;
  
  out1_im_tmp <= X"7FFF" WHEN (Dot_Product12_add_temp_1(16) = '0') AND (Dot_Product12_add_temp_1(15) /= '0') ELSE
      X"8000" WHEN (Dot_Product12_add_temp_1(16) = '1') AND (Dot_Product12_add_temp_1(15) /= '1') ELSE
      Dot_Product12_add_temp_1(15 DOWNTO 0);

  out1_re <= std_logic_vector(out1_re_tmp);

  out1_im <= std_logic_vector(out1_im_tmp);

END rtl;

