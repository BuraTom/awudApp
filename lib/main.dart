import 'dart:ui';
import 'package:awud_application/class/audio_file.dart';
import 'package:awud_application/localization/language_constants.dart';
import 'package:awud_application/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import "package:awud_application/pages/music.dart";
import "package:awud_application/pages/podcast.dart";
import "package:awud_application/pages/audiobook.dart";
import "package:awud_application/pages/library.dart";
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//var IpAddresse = "192.168.43.128";
var IpAddresse = "192.168.43.196";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  'pk_test_51L3gIJC995YiUADqJi1CmMaHawXkIApGcm953pfUVgnt5sDAPwUsunC2cGBbN052yRDvIprd0XMYVVfVf85vReaa00glO8LwgD';

  // num verify = 1;
  // if(verify == 1){
  //   runApp(login());
  // }else{
  //   runApp(navBar());
  // }
//  runApp(MyAppp());
 runApp(navBar());
}

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);
  @override
  _navBarState createState() => _navBarState();
  // static void setLocale(BuildContext context, Locale newLocale) {
  //   _navBarState? state = context.findAncestorStateOfType<_navBarState>();
  //   state?.setLocale(newLocale);
  // }
  // static void setLocale(BuildContext context, Locale newLocale) {
  //   _navBarState? state = context.findAncestorStateOfType<_navBarState>();
  //   state?.setLocale(newLocale);
  // }
}

class _navBarState extends State<navBar> {
  int _index = 0;
  int verifyer = 0;
  // Locale? _locale;
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) => {setLocale(locale)});
  //   super.didChangeDependencies();
  // }
  // Locale? _locale;
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) => {setLocale(locale)});
  //   super.didChangeDependencies();
  // }
  final screens = [
    // const login(),
    const Music(),
    const Podcast(),
    const Audiobook(),
    const Favuorite()
  ];

  PageController controller = PageController();
  // late Locale _locale;
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }
  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) {
  //     setState(() {
  //       this._locale = locale;
  //     });
  //   });
  //   super.didChangeDependencies();
  // }
  // @override
  // void init(){
  //   super.initState();
  //   // didChangeDependencies() {
  //   //   getLocale().then((locale) {
  //   //     setState(() {
  //   //       this._locale = locale;
  //   //     });
  //   //   });
  //   //   super.didChangeDependencies();
  //   // }
  //   getLocale().then((locale) {
  //     setState(() {
  //       _locale = locale;
  //     });
  //   });
  //    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: _locale,
      // supportedLocales: [
      //   Locale("en", "US"),
      //   Locale("am", "ET"),
      //   Locale("om", "ET"),
      //   Locale("ti", "ET")
      // ],
      // localizationsDelegates: [
      //   DemoLocalization.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // localeResolutionCallback: (locale, supportedLocales) {
      //   for (var supportedLocale in supportedLocales) {
      //     if (supportedLocale.languageCode == locale!.languageCode &&
      //         supportedLocale.countryCode == locale.countryCode) {
      //       return supportedLocale;
      //     }
      //   }
      //   return supportedLocales.first;
      // },

        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        //
        // locale: _locale,
        home: Scaffold(
          body: PageView.builder(
              itemCount: 5,
              controller: controller,
              onPageChanged: (page) {
                setState(() {
                  _index = page;
                });
              },
              itemBuilder: (context, position) {
                return Container(
                  child: screens[_index],
                );
              }),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(5),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              // backgroundColor: Colors.white,
              tabBackgroundColor: const Color.fromRGBO(248, 135, 88, 1),
              // tabBackgroundColor: const Color.fromRGBO(253, 157, 92, 1),
              // tabBackgroundColor: const Color.fromRGBO(234, 92, 78, 1),
              padding: const EdgeInsets.all(10),
              tabs: [
                GButton(
                  icon: FeatherIcons.music,
                  // text: getTranslated(context, 'mu')!,
                  text: 'Music',
                ),
                GButton(
                  icon: FeatherIcons.mic,
                  // text: getTranslated(context, 'pod')!
                  text: 'Podcast',
                ),
                GButton(
                  icon: FeatherIcons.bookOpen,
                  //text: getTranslated(context, 'aud')!
                  text: 'Audiobook',
                ),
                GButton(
                  icon: FeatherIcons.archive,
                  // text: getTranslated(context, 'lib')!
                  text: 'Library',
                  //text: translation(context).name,
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ));
  }
}
