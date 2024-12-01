import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:love_names/config/database_helper.dart';

import '../../model/contact.dart';
import '../../model/name.dart';
import '../../model/settings.dart';

class SelectNames extends StatefulWidget {
  final String title;
  final Contact contact;

  const SelectNames({Key? key, required this.title, required this.contact})
      : super(key: key);

  @override
  _SelectNamesState createState() => _SelectNamesState();
}

enum FREQUENCE { daily, weekly, monthly }

class _SelectNamesState extends State<SelectNames> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstLoveName = TextEditingController();
  TextEditingController secondLoveName = TextEditingController();
  TextEditingController thirdLoveName = TextEditingController();
  TextEditingController fourthLoveName = TextEditingController();
  TextEditingController fifthLoveName = TextEditingController();
  List<Contact>? _contacts, _contactsList;
  bool _permissionDenied = false, daily = false, weekly = false, montly = false;
  String? filter;
  String? _frequence;
  final databaseHelper = DatabaseHelper.instance;
  List<Names>? names;
  List<Settings>? settings;
  List<Contacts>? contacts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
             Text(
              'love_names_label'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: firstLoveName,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'first_love_name'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: secondLoveName,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'second_love_name'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: thirdLoveName,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'third_love_name'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: fourthLoveName,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'fourth_love_name'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: fifthLoveName,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'fifth_love_name'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Text(
              'frequency_label'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                RadioListTile(
                  title: Text('frequency_30_minutes_label'.tr()),
                  value: "30_minutes",
                  groupValue: _frequence,
                  onChanged: (value) {
                    setState(() {
                      _frequence = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('frequency_hourly_label'.tr()),
                  value: "hourly",
                  groupValue: _frequence,
                  onChanged: (value) {
                    setState(() {
                      _frequence = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('frequency_daily_label'.tr()),
                  value: "daily",
                  groupValue: _frequence,
                  onChanged: (value) {
                    setState(() {
                      _frequence = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('frequency_weekly_label'.tr()),
                  value: "weekly",
                  groupValue: _frequence,
                  onChanged: (value) {
                    setState(() {
                      _frequence = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('frequency_monthly_label'.tr()),
                  value: "monthly",
                  groupValue: _frequence,
                  onChanged: (value) {
                    setState(() {
                      _frequence = value.toString();
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () => _saveContacts(),
              child: Text(
                'register_name'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Save names settings in database
  _saveNames() {
    if (firstLoveName.text.isNotEmpty) {
      Names n = Names(firstLoveName.text, widget.contact.id, 0);
      databaseHelper.insertName(n);
    }

    if (secondLoveName.text.isNotEmpty) {
      Names n = Names(secondLoveName.text, widget.contact.id, 0);
      databaseHelper.insertName(n);
    }

    if (thirdLoveName.text.isNotEmpty) {
      Names n = Names(thirdLoveName.text, widget.contact.id, 0);
      databaseHelper.insertName(n);
    }

    if (fourthLoveName.text.isNotEmpty) {
      Names n = Names(fourthLoveName.text, widget.contact.id, 0);
      databaseHelper.insertName(n);
    }

    if (fifthLoveName.text.isNotEmpty) {
      Names n = Names(fifthLoveName.text, widget.contact.id, 0);
      databaseHelper.insertName(n);
    }
    Navigator.of(context).pop();
  }

  SnackBar _showSnackBarMessage(String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    return snackBar;
  }

  _saveContacts() async {
    final existedContact =
        await databaseHelper.queryContacts(widget.contact.id);
    if (existedContact.isEmpty) {
      Contacts contact = Contacts(
          widget.contact.id,
          widget.contact.displayName,
          widget.contact.phones.first.number,
          widget.contact.name.first,
          widget.contact.name.last
      );
      databaseHelper.insertContact(contact).then((value) {
        int timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
        Settings settings = Settings(
            _frequence, _countNames().toString(), widget.contact.id, timestamp);
        databaseHelper.insertSettings(settings).then((value) {
          _saveNames();
          ScaffoldMessenger.of(context).showSnackBar(
              _showSnackBarMessage('snackbar_select_name_msg_param'.tr()));
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_showSnackBarMessage('snackbar_select_name_msg_contact'.tr()));
    }
  }

  int _countNames() {
    int nameCount = 0;
    if (firstLoveName.text.isNotEmpty) {
      nameCount += 1;
    }
    if (secondLoveName.text.isNotEmpty) {
      nameCount += 1;
    }
    if (thirdLoveName.text.isNotEmpty) {
      nameCount += 1;
    }
    if (fourthLoveName.text.isNotEmpty) {
      nameCount += 1;
    }
    if (fifthLoveName.text.isNotEmpty) {
      nameCount += 1;
    }
    return nameCount;
  }
}
