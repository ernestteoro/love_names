import '../config/database_helper.dart';

class Contacts {
  String? id;
  String? name;
  String? phone;
  String? first_name;
  String? last_name;

  Contacts(this.id, this.name, this.phone, this.first_name, this.last_name);

  Contacts.fromMap(Map<String, dynamic> map) {
    id = map['id']!.toString();
    name = map['name']!;
    phone = map['phone']!;
    first_name = map['first_name']!;
    last_name = map['last_name']!;
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnContactId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnPhone: phone,
      DatabaseHelper.columnFirstName: first_name,
      DatabaseHelper.columnLastName: last_name,
    };
  }
}
