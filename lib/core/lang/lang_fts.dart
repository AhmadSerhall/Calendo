import 'package:flutter/material.dart';

// Global variable to store the current locale
Locale? currentLocale;

// Function to check if the current locale is Arabic
bool isArabicLocale() {
  return currentLocale?.languageCode == 'ar';
}

//experimental functions
bool _isRTLLanguage(Locale locale) {
  const rtlLanguages = ['ar']; // List of RTL language codes
  return rtlLanguages.contains(locale.languageCode);
}
