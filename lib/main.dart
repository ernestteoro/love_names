import 'dart:io';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:love_names/screens/Loved_ones_app.dart';

import 'config/alarm_task.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    await AndroidAlarmManager.initialize();
  }

  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('fr', 'FR'),
        child: const LovedOnesApp(),
      )
  );

  const int helloAlarmID = 0;
  if(Platform.isAndroid){
    await AndroidAlarmManager.periodic(
        rescheduleOnReboot: true,
        const Duration(minutes: 2),
        helloAlarmID,
        updateLoveNames
    );
  }
}