import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';
import '../db_helper.dart';

class DBParticipantTable extends DBBaseTable {
  @override
  final String db_table = 'participant';

  static const String sql_code = '''
    CREATE TABLE participant (
        participant_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        gender TEXT CHECK(gender IN ('female', 'male')),
        profession TEXT,
        date_of_birth DATE,
        phone_num TEXT,
        address TEXT,
        password TEXT,
        image BLOB
    );
  ''';

Future<void> dropTable() async {
  final db = await DBHelper.getDatabase(); // Access the database

  await db.execute('''
    DROP TABLE IF EXISTS participants;
  ''');
  print("Table dropped successfully");
}


Future<void> checkTableSchema() async {
    try {
      final db = await DBHelper.getDatabase();

      List<Map<String, dynamic>> result = await db.rawQuery('PRAGMA table_info(participant);');
      for (var column in result) {
        print('Column: ${column['name']}, Type: ${column['type']}');
      }
    } catch (e) {
      print('Error checking table schema: $e');
    }
  }

  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final db = await DBHelper.getDatabase();  
      print("inserting inot table");

      int rowId = await db.insert(
        db_table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace, 
      );

      return rowId > 0; 
    } catch (e, stacktrace) {
      print('Error inserting into $db_table: $e\nStackTrace: $stacktrace');
      return false;
    }
  }
  




  Future<Map<String, dynamic>> getLastRegisteredUser() async {
      try {
        final db = await DBHelper.getDatabase();
        final result = await db.rawQuery('SELECT * FROM participant ORDER BY participant_id DESC LIMIT 1');
        if (result.isNotEmpty) {
          return result.first;
        } else {
          print('No user found');
          throw Exception('No user found');
        }
      } catch (e) {
        print('Error fetching last registered user: $e');
        rethrow;
      }
  }



}
