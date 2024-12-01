import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utils/dimmensions.dart';
import 'loved_ones_home_page.dart';

class LovedOnesSplashScreen extends StatefulWidget {
  State<LovedOnesSplashScreen> createState() => _LovedOnesSplashScreenState();
}

class _LovedOnesSplashScreenState extends State<LovedOnesSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LovedOnesHomePage(title: 'app_title_label'.tr()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/img/bg.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/namelyme_512.png',
                    fit: BoxFit.fill,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  Text(
                    'application_name'.tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize * 1.5
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
