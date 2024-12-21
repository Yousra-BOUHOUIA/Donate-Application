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

      // Run PRAGMA query to get the table schema
      List<Map<String, dynamic>> result = await db.rawQuery('PRAGMA table_info(participant);');

      // Print out the result to inspect the schema
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
}
