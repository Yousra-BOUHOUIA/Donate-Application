import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';
import '../db_helper.dart';

class DBUserTable extends DBBaseTable {
  @override
  final String db_table = 'user';

  static const String sql_code = '''
    CREATE TABLE user (
        email TEXT PRIMARY KEY,
        password TEXT,
        contact_id INTEGER,
        FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
    );
  ''';

  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      // Validate required fields
      if (!data.containsKey('email') || !data.containsKey('password')) {
        throw Exception('Missing required fields: email or password.');
      }

      // Get database instance and perform insertion
      final database = await DBHelper.getDatabase();
      await database.insert(db_table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);

      return true;
    } catch (e, stacktrace) {
      // Log errors for debugging
      print('Error inserting into $db_table: $e --> $stacktrace');
    }
    return false;
  }
}
