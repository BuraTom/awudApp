// // import 'package:flutter/material.dart';
// // import 'demo_localization.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // const String LAGUAGE_CODE = 'languageCode';
// //
// // //languages code
// // const String ENGLISH = 'en';
// // const String amharic = 'am';
// // const String oromo = 'om';
// // const String tigrnya = 'ti';
// //
// // Future<Locale> setLocale(String languageCode) async {
// //   SharedPreferences _prefs = await SharedPreferences.getInstance();
// //   await _prefs.setString(LAGUAGE_CODE, languageCode);
// //   return _locale(languageCode);
// // }
// //
// // Future<Locale> getLocale() async {
// //   SharedPreferences _prefs = await SharedPreferences.getInstance();
// //   String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
// //   return _locale(languageCode);
// // }
// //
// // Locale _locale(String languageCode) {
// //   switch (languageCode) {
// //     case ENGLISH:
// //       return Locale(ENGLISH, 'US');
// //     case amharic:
// //       return Locale(amharic, "ET");
// //     case oromo:
// //       return Locale(oromo, "ET");
// //     case tigrnya:
// //       return Locale(tigrnya, "ET");
// //     default:
// //       return Locale(ENGLISH, 'US');
// //   }
// // }
// //
// // String? getTranslated(BuildContext context, String key) {
// //   return DemoLocalization.of(context)!.translate(key);
// // }
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// //import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// const String LAGUAGE_CODE = 'languageCode';
//
// //languages code
// const String ENGLISH = 'en';
// // const String FARSI = 'fa';
// // const String ARABIC = 'ar';
// // const String HINDI = 'hi';
// const String amh = 'am';
// // const String tig = 'ti';
// // const String oro = 'om';
// Future<Locale> setLocale(String languageCode) async {
//   SharedPreferences _prefs = await SharedPreferences.getInstance();
//   await _prefs.setString(LAGUAGE_CODE, languageCode);
//   return _locale(languageCode);
// }
//
// Future<Locale> getLocale() async {
//   SharedPreferences _prefs = await SharedPreferences.getInstance();
//   String languageCode = _prefs.getString(LAGUAGE_CODE) ?? amh;
//   return _locale(languageCode);
// }
//
// Locale _locale(String languageCode) {
//   switch (languageCode) {
//     case ENGLISH:
//       return const Locale(ENGLISH, '');
//   // case FARSI:
//   //   return const Locale(FARSI, "");
//   // case ARABIC:
//   //   return const Locale(ARABIC, "");
//   // case HINDI:
//   //   return const Locale(HINDI, "");
//     case amh:
//       return const Locale(amh, "");
//   // case tig:
//   //   return const Locale(tig, "");
//   // case oro:
//   //   return const Locale(oro, "");
//     default:
//       return const Locale(ENGLISH, '');
//   }
// }
//
// AppLocalizations translation(BuildContext context) {
//   // print(context);
//   return AppLocalizations.of(context)!;
// }