import 'package:love_names/model/name.dart';
import 'package:love_names/model/settings.dart';

import 'contact.dart';

class ContactSettings {
  Contacts? contacts;
  List<Names>? names;
  Settings? settings;
  String? settingFrequence;

  ContactSettings(
      this.contacts,
      this.names,
      this.settings,
      this.settingFrequence
      );


}
