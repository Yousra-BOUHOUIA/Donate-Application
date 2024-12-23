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
      DROP TABLE IF EXISTS participant;
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

  // Print all records in the participant table
  Future<void> printAllRecords() async {
    final db = await DBHelper.getDatabase();
    try {
      List<Map<String, dynamic>> records = await db.query(db_table);
      if (records.isEmpty) {
        print('No records found in the $db_table table.');
      } else {
        print('All records in the $db_table table:');
        for (var record in records) {
          print(record); // Printing the whole record
        }
      }
    } catch (e) {
      print('Error retrieving records: $e');
    }
  }

  Future<int> insertRecord(Map<String, dynamic> data) async {
    print("Waiting to get the database...");

    final db = await DBHelper.getDatabase();

    bool tableExists = await DBHelper.isTableExists(db_table);
    if (!tableExists) {
      print("Table '$db_table' does not exist!");
      print("SQL for creating table: ${DBParticipantTable.sql_code}");

      try {
        print("Creating '$db_table' table...");
        await db.execute(DBParticipantTable.sql_code);
        print("Table '$db_table' created successfully.");
      } catch (e) {
        print("Error creating table: $e");
        return -1;
      }
    }

    try {
      print("Inserting into table '$db_table'");
      int rowId = await db.insert(
        db_table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // After inserting, print all records
      await printAllRecords(); // Print all records after inserting

      return rowId > 0 ? rowId : -1;
    } catch (e, stacktrace) {
      print('Error inserting into $db_table: $e\nStackTrace: $stacktrace');
      return -1;
    }
  }

Future<String> getPasswordById(int participantId) async {
    final db = await DBHelper.getDatabase();

    List<Map<String, dynamic>> result = await db.query(
      'participant',
      columns: ['password'],
      where: 'participant_id = ?',
      whereArgs: [participantId],
    );

    if (result.isNotEmpty) {
      return result.first['password'] as String;
    } else {
      throw Exception("Participant not found");
    }
  }

  Future<bool> updateRecord(Map<String, dynamic> data, String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      await database.update(
        db_table,
        data,
        where: "$column = ?",
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // After updating, print all records
      await printAllRecords(); // Print all records after updating

      return true;
    } catch (e, stacktrace) {
      print('Error updating $db_table: $e --> $stacktrace');
    }
    return false;
  }
}
