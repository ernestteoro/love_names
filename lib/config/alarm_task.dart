//import 'package:flutter_contacts/contact.dart';
//import 'package:flutter_contacts/flutter_contacts.dart';
//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:love_names/config/database_helper.dart';
import 'package:love_names/model/contact.dart';
import 'package:love_names/model/name.dart';

import '../model/settings.dart';
import '../utils/utils.dart';

final databaseHelper = DatabaseHelper.instance;

@pragma('vm:entry-point')
void updateLoveNames() async {

  // Get list of contacts from database
    List<Contacts> contacts = await getContacts();
    for (var contact in contacts) {
      Settings settings = await getSettingsByContactId(contact.id!);
      List<Names> names = await getNamesByContactId(contact.id!);
      final DateTime dateTime = DateTime.now();
      final DateTime settingDate = DateTime.fromMillisecondsSinceEpoch(settings.setting_date!);
      final diff = dateTime.difference(settingDate);

      if ((settings.frequence == "30_minutes" && diff.inMinutes >= 30 && diff.inMinutes <= 32) ||
          (settings.frequence == "hourly" && diff.inHours >= 1 && diff.inHours <2) ||
          (settings.frequence=="daily" && diff.inHours>=24 && diff.inHours<=26) ||
          (settings.frequence=="weekly" && diff.inDays>=7 && diff.inDays<=9) ||
          (settings.frequence=="monthly" && (diff.inDays>=28 || diff.inDays>=30 || diff.inDays<=31)))
      {
        updatecontactNameAndSettings(settings, contact, names);
      }
    }

}

void updatecontactNameAndSettings(Settings settings, Contacts contact, List<Names> names) async{
  for (var name in names) {
    if (name.done == 0) {
      Contact? contactToUpdate = await FlutterContacts.getContact(contact.id!,withAccounts:true, withProperties: true);
      nameIndex+=1;
      if (contactToUpdate!=null) {

        contactToUpdate.displayName = name.name!;
        contactToUpdate.name.first = name.name!;
        contactToUpdate.name.last ='';
        contactToUpdate.name.nickname = '';
        contactToUpdate.name.middle ='';

        await FlutterContacts.updateContact(contactToUpdate);
        name.done = 1;
        await databaseHelper.updateName(name);
        settings.setting_date =
            DateTime.now().toUtc().millisecondsSinceEpoch;
        await databaseHelper.updateSettings(settings);
        contact.name = name.name;
        await databaseHelper.updatetContact(contact);
        await FlutterContacts.getContact(contactToUpdate.id,withAccounts:true, withProperties: true);

      }
      break;
    }
  }
}

Future<List<Contacts>> getContacts() async {
  List<Contacts> contacts = [];
  final allContacts = await databaseHelper.queryAllContacts();
  for (var contact in allContacts) {
    contacts.add(Contacts.fromMap(contact));
  }

  return contacts;
}

Future<List<Names>> getNamesByContactId(String contactId) async {
  List<Names> names = [];
  final allNames = await databaseHelper.queryNames(contactId);
  for (var name in allNames) {
    names.add(Names.fromMap(name));
  }

  return names;
}

Future<Settings> getSettingsByContactId(String contactId) async {
  final nameSettings = await databaseHelper.querySettings(contactId);
  return Settings.fromMap(nameSettings.first);
}

