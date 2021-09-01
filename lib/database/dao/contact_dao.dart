import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> create(Contact contact) async {
    final Database db = await getDatabase();
    return await db.insert(_tableName, contact.toJson());
  }

  Future<List<Contact>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return result
        .map((Map<String, dynamic> row) => Contact.fromJson(row))
        .toList();
  }

  Future<void> update(Contact contact) async {
    final Database db = await getDatabase();
    await db.update(
      _tableName,
      contact.toJson(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> delete(int id) async {
    final Database db = await getDatabase();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}