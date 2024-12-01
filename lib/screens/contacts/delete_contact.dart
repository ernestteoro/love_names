import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:love_names/config/database_helper.dart';
import 'package:love_names/model/contact.dart';
import 'package:love_names/model/name.dart';
import 'package:love_names/model/settings.dart';

import '../../model/contact_settings.dart';

class DeleteContact extends StatefulWidget {
  const DeleteContact({Key? key}) : super(key: key);

  @override
  State<DeleteContact> createState() => _DeleteContactState();
}

class _DeleteContactState extends State<DeleteContact> {
  TextEditingController searchController = TextEditingController();
  List<Contacts>? _contacts, _contactsList;
  List<ContactSettings> contactSettings = [];
  List<Names>? _names;
  List<Settings>? _settings;
  String? filter;
  final databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  void didUpdateWidget(covariant DeleteContact oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => _filterContact(value),
              decoration: InputDecoration(
                hintText: 'search_contact'.tr(),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 15.0),
            physics: BouncingScrollPhysics(),
            itemCount: contactSettings.isNotEmpty ? contactSettings.length : 0,
            itemBuilder: (BuildContext context, int i) {
              ContactSettings cs = contactSettings[i];
              return Dismissible(
                  background: Container(color: Colors.red),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    _deleteContactAndSettings(cs.contacts!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            '${cs.contacts!.name}  ${'contact_settings_deleted'.tr()}')));
                  },
                  child: Card(
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text(
                        cs.contacts!.name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${'frequency_text_label'.tr()} ',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(cs.settingFrequence!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${'total_name_label'.tr()} ',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text('${cs.names!.length}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))
                              ],
                            )
                          ]),
                      /*
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_rounded,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        onPressed: () => _deleteContactAndSettings(cs.contacts!),
                      ),

                       */
                    ),
                  )
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ))
        ],
      ),
    );
  }

  /*
  Slidable(
                key: const ValueKey(0),

                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),
                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () => _deleteContactAndSettings(cs.contacts!)),
                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'delete_contact_label'.tr(),
                      onPressed: (context) => _deleteContactAndSettings(cs.contacts!),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'delete_contact_label'.tr(),
                      onPressed: (context) => _deleteContactAndSettings(cs.contacts!),
                    ),
                  ],
                ),
                child: Card(
                  color: Colors.blueAccent,
                  child: ListTile(
                    title: Text(
                      cs.contacts!.name!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${'frequency_text_label'.tr()} : ',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(cs.settingFrequence!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${'total_name_label'.tr()} : ',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text('${cs.names!.length}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white))
                            ],
                          )
                        ]),
                  ),
                ),
              );





   */

  _deleteContactAndSettings(Contacts contacts) async {
    int count = await databaseHelper.deleteContact(contacts);
    if (count > 0) {
      await databaseHelper.deleteSettings(contacts.id!);
      await databaseHelper.deleteNames(contacts.id!);
      _fetchContacts();
    }
  }

  Future _fetchContacts() async {
    final contacts = await databaseHelper.queryAllContacts();
    for (var contact in contacts) {
      Contacts con = Contacts.fromMap(contact);
      Settings stgs = await _fetchSettings(con.id!);
      String settingsFrequence = await _fetchSettingsFrequence(con.id!);
      List<Names> nms = await _fetchNames(con.id!);
      ContactSettings cs = ContactSettings(con, nms, stgs, settingsFrequence);
      setState(() {
        contactSettings.add(cs);
      });
    }
  }

  _filterContact(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _contactsList = _contacts!
            .where((contact) => contact.name!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      } else {
        _contactsList = _contacts;
      }
    });
  }

  Future<List<Names>> _fetchNames(String contactId) async {
    final names = await databaseHelper.queryNames(contactId);
    return names.map((n) => Names.fromMap(n)).toList();
  }

  Future<String> _fetchSettingsFrequence(String contactId) async {
    final settings = await databaseHelper.querySettings(contactId);
    String frequencyName = '';
    _settings = settings.map((set) => Settings.fromMap(set)).toList();
    switch (_settings!.first.frequence) {
      case '30_minutes':
        setState(() {
          frequencyName = 'frequency_30_minutes_label'.tr();
        });
        break;
      case 'daily':
        setState(() {
          frequencyName = 'frequency_daily_label'.tr();
        });
        break;
      case 'weekly':
        setState(() {
          frequencyName = 'frequency_weekly_label'.tr();
        });
        break;
      case 'monthly':
        setState(() {
          frequencyName = 'frequency_monthly_label'.tr();
        });
        break;
    }

    return frequencyName;
  }

  Future<Settings> _fetchSettings(String contactId) async {
    final settings = await databaseHelper.querySettings(contactId);
    return settings.map((set) => Settings.fromMap(set)).toList().first;
  }
}
