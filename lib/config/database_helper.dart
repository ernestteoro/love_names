import 'package:love_names/model/contact.dart';
import 'package:love_names/model/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/name.dart';

class DatabaseHelper {
  static const _databaseName = "lovenames.db";
  static const _databaseVersion = 1;

  // Contact table description
  static const tableContact = 'contacts';
  static const columnContactId = 'id';
  static const columnName = 'name';
  static const columnPhone = 'phone';
  static const columnFirstName = 'first_name';
  static const columnLastName = 'last_name';

  // Names table description
  static const tableName = 'names';
  static const columnNameId = 'id';
  static const columnNameName = 'name';
  static const columnNameContactId = 'id_contact';
  static const columnNameDone = 'done';

  // Setting table description
  static const tableSettings = 'settings';
  static const columnSettingsId = 'id';
  static const columnSettingsFrequence = 'frequence';
  static const columnSettingsTotalName = 'name_count';
  static const columnSettingsContactId = 'id_contact';
  static const columnSettingsDate = 'setting_date';

// make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableContact (
    $columnContactId TEXT PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnPhone TEXT NOT NULL,
    $columnFirstName TEXT NOT NULL,
    $columnLastName TEXT NOT NULL)''');

    await db.execute('''CREATE TABLE $tableName (
    $columnNameId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnNameName TEXT NOT NULL,
    $columnNameContactId TEXT NOT NULL,
    $columnNameDone INTEGER NOT NULL)''');

    await db.execute('''CREATE TABLE $tableSettings (
    $columnSettingsId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnSettingsFrequence TEXT NOT NULL,
    $columnSettingsTotalName TEXT NOT NULL,
    $columnSettingsContactId TEXT NOT NULL,
    $columnSettingsDate INTEGER NOT NULL)''');
  }

  Future<int> insertContact(Contacts contacts) async {
    Database db = await instance.database;
    return await db.insert(tableContact, {'id': contacts.id,'name': contacts.name, 'phone': contacts.phone, 'first_name': contacts.first_name, 'last_name': contacts.last_name});
  }


  Future<int> updatetContact(Contacts contacts) async {
    Database db = await instance.database;
    return await db.update(tableContact, {'name': contacts.name}, where: 'id =?', whereArgs: [contacts.id]);
  }

  Future<int> deleteContact(Contacts contacts) async {
    Database db = await instance.database;
    int rowCount =0;
    rowCount = await db.delete(tableContact, where: 'id = ?', whereArgs: [contacts.id]);
    return rowCount;
  }


  Future<int> deleteSettings(String contactId) async {
    Database db = await instance.database;
    return await db.delete(tableSettings, where: "id_contact = ?", whereArgs: [contactId]);
  }

  Future<int> deleteNames(String contactId) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: "id_contact = ?", whereArgs: [contactId]);
  }


  Future<int> insertName(Names names) async {
    Database db = await instance.database;
    return await db.insert(tableName, {'id': names.id,'name': names.name, 'id_contact': names.id_contact, 'done': names.done});
  }

  Future<int> insertSettings(Settings settings) async {
    Database db = await instance.database;
    return await db.insert(tableSettings, {'id': settings.id,'frequence': settings.frequence, 'name_count': settings.name_count, 'id_contact': settings.id_contact, 'setting_date': settings.setting_date});
  }

  Future<int> updateName(Names names) async {
    Database db = await instance.database;
    return await db.update(tableName, {'done': names.done,'name': names.name}, where: "id = ?", whereArgs: [names.id]);
  }

  Future<int> updateSettings(Settings settings) async {
    Database db = await instance.database;
    return await db.update(tableSettings, {'setting_date': settings.setting_date}, where: "id = ?", whereArgs: [settings.id]);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllContacts() async {
    Database db = await instance.database;
    return await db.query(tableContact);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryContacts(contactId) async {
    Database db = await instance.database;
    return await db.query(tableContact, where: "$columnContactId = '$contactId'");
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryNames(contactId) async {
    Database db = await instance.database;
    return await db.query(tableName, where: "$columnNameContactId ='$contactId'");
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryAllNames() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> querySettings(contactId) async {
    Database db = await instance.database;
    return await db.query(tableSettings, where: "$columnSettingsContactId LIKE '%$contactId%'");
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryAllSettings() async {
    Database db = await instance.database;
    return await db.query(tableSettings);
  }

}
