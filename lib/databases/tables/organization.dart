import '../../databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';


class DBOrganizationTable{

  final String db_table = 'organization';

  static const String sql_code = '''
    CREATE TABLE organization (
 organization_id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT,
        contact_id INTEGER,
        social_media_id INTEGER,
        notif_id INTEGER,
        organization_name TEXT,
        phone_num TEXT,
        address TEXT,
        money_transaction BOOLEAN,
        bank_account TEXT,
        organization_type TEXT,
        image BLOB,
        description TEXT,
        uploaded_files BLOB,
        FOREIGN KEY (social_media_id) REFERENCES Social_Media(social_media_id),
        FOREIGN KEY (notif_id) REFERENCES Notification(notif_id),
        FOREIGN KEY (card_id) REFERENCES Card(card_id),
        FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
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

  Future<List<Map<String, dynamic>>> getAllRecords() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(db_table);
    } catch (e, stacktrace) {
      print('Error fetching records from $db_table: $e --> $stacktrace');
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> getDonations() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        db_table,
        where: "type = ?",
        whereArgs: ['donation'],
      );
    } catch (e, stacktrace) {
      print('Error fetching donations from $db_table: $e --> $stacktrace');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        db_table,
        where: "type = ?",
        whereArgs: ['event'],
      );
    } catch (e, stacktrace) {
      print('Error fetching events from $db_table: $e --> $stacktrace');
      return [];
    }
  }
}
