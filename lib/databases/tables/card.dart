import 'package:donate_application/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../databases/db_base.dart';

class DBCardTable extends DBBaseTable {
  @override
  var db_table = 'card';

  static String sql_code = '''
    CREATE TABLE card (
        card_id INTEGER PRIMARY KEY,
        image BLOB,
        location TEXT,
        title TEXT
    );
  ''';

  // Insert method to add a new record to the 'card' table
  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      await database.insert(db_table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  // Delete method to remove a record from the 'card' table based on a column and value
  Future<bool> deleteRecord(String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      int deletedCount = await database.delete(
        db_table,
        where: "$column = ?",
        whereArgs: [id],
      );
      return deletedCount > 0;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  // Update method to modify an existing record in the 'card' table
  Future<bool> updateRecord(
      Map<String, dynamic> data, String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      int updatedCount = await database.update(
        db_table,
        data,
        where: "$column = ?",
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return updatedCount > 0;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }
}
