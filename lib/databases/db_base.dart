import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class DBBaseTable {
  var db_table = 'TABLE_NAME_MUST_OVERRIDE';

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
      print('$e --> $stacktrace');
    }
    return false;
  }

  void fetchParticipants() async {
    // Get the database instance
    final database = await DBHelper.getDatabase();

    // Query the 'participant' table
    List<Map<String, dynamic>> participants =
        await database.query('participant');

    // Print the participants data
    participants.forEach((participant) {
      print(participant);
    });
  }
}
