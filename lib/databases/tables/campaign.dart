import 'package:donate_application/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';

class DBCampaignTable extends DBBaseTable {
  @override
  final String db_table = 'campaign';

  static const String sql_code = '''
    CREATE TABLE campaign (
        campaign_id INTEGER PRIMARY KEY,
        card_id INTEGER,
        campaign_name TEXT,
        start_date DATE,
        end_date DATE,
        FOREIGN KEY (card_id) REFERENCES Card(card_id)
    );
    ''';

  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      await database.insert(db_table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e, stacktrace) {
      print('Error inserting into $db_table: $e --> $stacktrace');
    }
    return false;
  }

  @override
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
      print('$e --> $stacktrace');
    }
    return null;
  }

  @override
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
      print('$e --> $stacktrace');
    }
    return false;
  }
}
