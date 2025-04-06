import 'package:flutter/material.dart';

bool isLocaleEn(context) {
  Locale myLocale = Localizations.localeOf(context);
  String code = myLocale.languageCode;
  //log(code);
  if (code == 'en') {
    //log('en true');
    return true;
  }
  return false;
}
