import 'package:admin/core/constants/constraints.dart';
import 'package:admin/core/lang/lang_fts.dart';
import 'package:flutter/material.dart';

TextStyle get headline1 => TextStyle(
  fontSize: isTablet ? 24 * 1.8 : 24,
  fontFamily: isArabicLocale() ? 'Esnad' : 'Poppins',
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

TextStyle get headline2 => TextStyle(
  fontSize: isTablet ? 20 * 1.8 : 20,
  fontFamily: isArabicLocale() ? 'Esnad' : 'Poppins',
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

TextStyle get headline3 => TextStyle(
  fontSize: isTablet ? 18 * 1.8 : 18,
  fontFamily: isArabicLocale() ? 'Almarai' : 'Nunito Sans',
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

TextStyle get bodyText1 => TextStyle(
  fontSize: isTablet ? 16 * 1.8 : 16,
  fontFamily: isArabicLocale() ? 'Almarai' : 'Nunito Sans',
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

TextStyle get bodyText2 => TextStyle(
  fontSize: isTablet ? 14 * 1.8 : 14,
  fontFamily: isArabicLocale() ? 'Almarai' : 'Nunito Sans',
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

TextStyle get caption => TextStyle(
  fontSize: isTablet ? 12 * 1.8 : 12,
  fontFamily: isArabicLocale() ? 'Almarai' : 'Nunito Sans',
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

TextStyle get button => TextStyle(
  fontSize: isTablet ? 14 * 1.8 : 14,
  fontFamily: isArabicLocale() ? 'Almarai' : 'Nunito Sans',
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle get overline => TextStyle(
  fontSize: isTablet ? 10 * 1.8 : 10,
  fontFamily: isArabicLocale() ? 'Almarai' : 'Nunito Sans',
  fontWeight: FontWeight.normal,
  color: Colors.black,
);
