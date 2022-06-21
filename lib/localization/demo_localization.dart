// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class DemoLocalization {
//   DemoLocalization(this.locale);
//
//   final Locale locale;
//   static DemoLocalization? of(BuildContext context) {
//     return Localizations.of<DemoLocalization>(context, DemoLocalization);
//   }
//
//   Map<String, String>? _localizedValues;
//
//   Future<void> load() async {
//     String jsonStringValues =
//     await rootBundle.loadString('lib/l10n/${locale.languageCode}.json');
//     Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
//     _localizedValues =
//         mappedJson.map((key, value) => MapEntry(key, value.toString()));
//   }
//
//   String? translate(String key) {
//     return _localizedValues![key];
//   }
//
//   // static member to have simple access to the delegate from Material App
//   static const LocalizationsDelegate<DemoLocalization> delegate =
//   _DemoLocalizationsDelegate();
// }
//
// class _DemoLocalizationsDelegate
//     extends LocalizationsDelegate<DemoLocalization> {
//   const _DemoLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'am', 'om', 'ti'].contains(locale.languageCode);
//   }
//
//   @override
//   Future<DemoLocalization> load(Locale locale) async {
//     DemoLocalization localization = new DemoLocalization(locale);
//     await localization.load();
//     return localization;
//   }
//
//   @override
//   bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => false;
// }




class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      // Language(1, "🇦🇫", "فارسی", "fa"),
      Language(1, "🇺🇸", "English", "en"),
      // Language(3, "🇸🇦", "اَلْعَرَبِيَّةُ", "ar"),
      // Language(4, "🇮🇳", "हिंदी", "hi"),
      Language(2, "ET", "አማርኛ", "am"),
      // Language(6, "ET", "ትግሪኛ", "ti"),
      // Language(7, "ET", "Afaan Aroomaa", "om")
    ];
  }
}