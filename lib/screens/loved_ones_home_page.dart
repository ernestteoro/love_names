
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/database_helper.dart';
import '../model/contact.dart';
import '../model/name.dart';
import '../model/settings.dart';
import 'contacts/delete_contact.dart';
import 'loved_ones_settings_page.dart';

class LovedOnesHomePage extends StatefulWidget {
  final String title;

  LovedOnesHomePage({super.key, required this.title});

  @override
  State<LovedOnesHomePage> createState() => _LovedOnesHomePageState();
}

class _LovedOnesHomePageState extends State<LovedOnesHomePage> {
  Contact? contact;
  final databaseHelper = DatabaseHelper.instance;
  List<Names>? names;
  List<Settings>? settings;
  List<Contacts>? contacts;
  String pagetitle='setting_page_label'.tr();

  late final Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  int _currentIndex =0;
  final List<Widget> pages = const [
    LovedOnesSettingsPage(),
    DeleteContact()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestContactPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pagetitle),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications_sharp),
            tooltip:"tabbar_setting_label".tr(),
            label: "tabbar_setting_label".tr()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            tooltip:"tabbar_suppression_label".tr(),
            label: "tabbar_suppression_label".tr()
          ),
        ],
        onTap:(index) => changeHomePage(index),
        elevation: 15.5,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changeHomePage(int index){
    setState(() {
      pagetitle = index==0? 'setting_page_label'.tr(): 'delete_page_label'.tr();
      _currentIndex = index;
    });
  }

  SnackBar showSnackBar(String message) {
    return SnackBar(content: Text(message));
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> requestContactPermission() async {
    final serviceStatus = await Permission.contacts.isGranted ;
    bool isContactsOn = serviceStatus == ServiceStatus.enabled;
    final status = await Permission.contacts.request();

    if (status == PermissionStatus.granted) {
      //print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      //print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      //print('Permission Permanently Denied');
      await openAppSettings();
    }
  }
}
