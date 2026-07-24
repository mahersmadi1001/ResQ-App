import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;
  static String currentLanguage = 'en';
  static AppLocalizations? instance;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  late Map<String, dynamic> _jsonMap;

  Future<bool> load() async {
    currentLanguage = locale.languageCode;
    instance = this;
    final String jsonString = await rootBundle.loadString(
      'assets/lang/${locale.languageCode}.json',
    );
    _jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return true;
  }

  String translate(String key) {
    final parts = key.split('.');
    dynamic current = _jsonMap;

    for (final part in parts) {
      if (current is Map<String, dynamic> && current.containsKey(part)) {
        current = current[part];
      } else {
        return key;
      }
    }

    return current is String ? current : key;
  }

  static String trNoContext(String key) {
    return instance?.translate(key) ?? key;
  }

  String tr(String key) => translate(key);
}

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return AppLocalizations.of(this)?.tr(key) ?? key;
  }

  String get languageCode => AppLocalizations.currentLanguage;
}
