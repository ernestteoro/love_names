
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:love_names/screens/contacts/select_contact.dart';
import 'package:love_names/screens/names/select_names.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/database_helper.dart';
import '../model/contact.dart';
import '../model/name.dart';
import '../model/settings.dart';


class LovedOnesSettingsPage extends StatefulWidget {

  const LovedOnesSettingsPage({super.key});

  @override
  State<LovedOnesSettingsPage> createState() => _LovedOnesSettingsPageState();
}

class _LovedOnesSettingsPageState extends State<LovedOnesSettingsPage> {
  Contact? contact;
  final databaseHelper = DatabaseHelper.instance;
  List<Names>? names;
  List<Settings>? settings;
  List<Contacts>? contacts;

  late final Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (contact != null)
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: _height / 35),
                    contact!.photo == null
                        ? CircleAvatar(
                        radius: _width < _height ? _width / 6 : _height / 6,
                        backgroundImage:
                        const AssetImage("assets/img/profile.png"))
                        : CircleAvatar(
                        radius: _width < _height ? _width / 6 : _height / 6,
                        backgroundImage: MemoryImage(contact!.photo!)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(contact!.displayName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 15,
                            color: Colors.black)),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(contact!.phones.first.number,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 25,
                            color: Colors.black)),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectContact(
                              title: 'select_contact'.tr())))
                      .then((selectedContact) {
                    setState(() {
                      contact = selectedContact;
                    });
                  });
                },
                child: Text(
                  'select_contact'.tr(),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if(contact!=null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectNames(
                              title: 'name_page_title'.tr(),
                              contact: contact!,
                            ))
                    ).then((value) {

                    });
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(showSnackBar('snackbar_message'.tr()));
                  }
                },
                child: Text('select_love_name'.tr(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    )
                )
            )
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
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

}
