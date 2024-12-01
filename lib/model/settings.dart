import '../config/database_helper.dart';

class Settings{
  int? id;
  String? frequence;
  String? name_count;
  String? id_contact;
  int? setting_date;

  Settings(this.frequence, this.name_count, this.id_contact, this.setting_date);

  Settings.fromMap(Map<String, dynamic> map) {
    id = map['id']!;
    frequence = map['frequence']!;
    name_count = map['name_count']!;
    id_contact = map['id_contact']!;
    setting_date = map['setting_date']!;
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnSettingsId: id,
      DatabaseHelper.columnSettingsFrequence: frequence,
      DatabaseHelper.columnSettingsTotalName: name_count,
      DatabaseHelper.columnSettingsContactId: id_contact,
      DatabaseHelper.columnSettingsDate: setting_date
    };
  }
}