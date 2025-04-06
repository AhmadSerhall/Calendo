import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//list of available languages
final List<Locale> availableLocales = [
  const Locale('en', 'US'),
  const Locale('ar', 'AE'),
];

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code clean and easy to use
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  late Map<String, dynamic> _localizedStrings;

  // Load the JSON file from assets based on the locale
  Future<bool> load() async {
    try {
      // Load JSON file from assets (default method)
      String jsonString = await rootBundle
          .loadString('assets/translations/${locale.languageCode}.json');

      // Decode the JSON string into a Map
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Convert dynamic map to Map<String, dynamic>
      _localizedStrings = jsonMap;

      return true;
    } catch (e) {
      print("Error loading localization data: $e");
      return false;
    }
  }

  // Method to get translated value by key
  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic map = _localizedStrings;

    for (String k in keys) {
      if (map is Map) {
        map = map[k];
      } else {
        return key;
      }
    }

    return map?.toString() ?? key;
  }
}

// Delegate class for the localization
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Specify the supported locales
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Create an instance of AppLocalizations and load the JSON data
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Add a constant delegate for ease of use
const LocalizationsDelegate<AppLocalizations> appLocalizationsDelegate =
    _AppLocalizationsDelegate();
