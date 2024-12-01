import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'loved_ones_splash_screen.dart';


class LovedOnesApp extends StatelessWidget {
  const LovedOnesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'app_title_label'.tr(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context){
          return LovedOnesSplashScreen();
        },
      ),
    );
  }
}