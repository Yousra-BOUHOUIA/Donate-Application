import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class DBUser_donationTable {

  final String db_table = 'user_donation';

  static const String sql_code = '''
  CREATE TABLE user_donation (
    donation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    image BLOB,
    color TEXT,
    condition TEXT,
    contact TEXT,
    location TEXT,
    username
   
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
    print("SQL for creating table: ${DBUser_donationTable.sql_code}");  // Replace with the actual SQL code for creating the table

    // Attempt to create the table
    try {
      print("Creating '$db_table' table...");
      await db.execute(DBUser_donationTable.sql_code);  // Assuming this SQL code creates the table
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


Future<List<Map<String, dynamic>>> getAllRecords() async {
  try {
    final db = await DBHelper.getDatabase(); // Get the database instance

    // Query all records from the table
    List<Map<String, dynamic>> records = await db.query(db_table);

    print("Fetched ${records.length} records from the '$db_table' table.");
    return records;
  } catch (e) {
    print("Error fetching records from $db_table: $e");
    return []; // Return an empty list in case of an error
  }
}

}
