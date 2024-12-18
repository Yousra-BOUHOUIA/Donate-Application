import 'package:donate_application/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DBCampaignTable {
  final String db_table = 'campaign';

  static const String sql_code = '''
    CREATE TABLE campaign (
        campaign_id INTEGER PRIMARY KEY AUTOINCREMENT,
        image BLOB,
        location TEXT,
        title TEXT,
        type TEXT CHECK(type IN ('event', 'donation')),
        resource INTEGER,
        description TEXT,
        campaign_date DATE
    );
  ''';

  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      await database.insert(
        db_table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e, stacktrace) {
      print('Error inserting into $db_table: $e --> $stacktrace');
    }
    return false;
  }

  Future<Map<String, dynamic>?> getRecord(String column, dynamic id,
      {String? condition, List<dynamic>? conditionArgs}) async {
    try {
      final database = await DBHelper.getDatabase();
      String whereClause = "$column = ?";
      List<dynamic> whereArgs = [id];

      if (condition != null && conditionArgs != null) {
        whereClause = "$whereClause AND $condition";
        whereArgs.addAll(conditionArgs);
      }

      var result = await database.query(
        db_table,
        where: whereClause,
        whereArgs: whereArgs,
        limit: 1,
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e, stacktrace) {
      print('Error retrieving from $db_table: $e --> $stacktrace');
    }
    return null;
  }

  Future<bool> updateRecord(
      Map<String, dynamic> data, String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      await database.update(
        db_table,
        data,
        where: "$column = ?",
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e, stacktrace) {
      print('Error updating $db_table: $e --> $stacktrace');
    }
    return false;
  }

  Future<bool> deleteRecord(String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      int count = await database.delete(
        db_table,
        where: "$column = ?",
        whereArgs: [id],
      );
      return count > 0;
    } catch (e, stacktrace) {
      print('Error deleting from $db_table: $e --> $stacktrace');
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> fetchCampaigns() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(db_table);
    } catch (e, stacktrace) {
      print('Error fetching campaigns from $db_table: $e --> $stacktrace');
      return [];
    }
  }
}
