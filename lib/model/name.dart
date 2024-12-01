import '../config/database_helper.dart';

class Names{
  int? id;
  String? name;
  String? id_contact;
  int done =0;

  Names(this.name, this.id_contact, this.done);

  Names.fromMap(Map<String, dynamic> map) {
    id = map['id']!;
    name = map['name']!;
    id_contact = map['id_contact']!;
    done = map['done']!;
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnNameId: id,
      DatabaseHelper.columnNameName: name,
      DatabaseHelper.columnNameContactId: id_contact,
      DatabaseHelper.columnNameDone: done
    };
  }
}