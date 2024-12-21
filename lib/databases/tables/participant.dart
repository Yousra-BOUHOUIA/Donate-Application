import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class DBParticipantTable {
  
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
  final db = await DBHelper.getDatabase(); 

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


Future<int> insertRecord(Map<String, dynamic> data) async {
  print("waiting getdatabase");

  final db = await DBHelper.getDatabase();

  // Check if the table exists before performing the insert
  bool tableExists = await DBHelper.isTableExists(db_table); // db_table should be a variable containing the table name
  if (!tableExists) {
    print("Table '$db_table' does not exist!");
    print("SQL for creating table: ${DBParticipantTable.sql_code}");  // Replace with the actual SQL code for creating the table

    // Attempt to create the table
    try {
      print("Creating '$db_table' table...");
      await db.execute(DBParticipantTable.sql_code);  // Assuming this SQL code creates the table
      print("Table '$db_table' created successfully.");
    } catch (e) {
      print("Error creating table: $e");
      return -1; // Return -1 or handle it in another way if table creation fails
    }
  }

  try {
    print("Inserting into table '$db_table'");
    int rowId = await db.insert(
      db_table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rowId > 0 ? rowId : -1; // Return rowId or -1 if insertion fails
  } catch (e, stacktrace) {
    print('Error inserting into $db_table: $e\nStackTrace: $stacktrace');
    return -1;  // Return -1 or handle errors as needed
  }
}

}