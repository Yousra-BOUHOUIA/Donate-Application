import 'package:donate_application/databases/db_helper.dart';

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
    participant_id INTEGER,
    FOREIGN KEY(participant_id) REFERENCES participants(participant_id)
  );
  ''';

  Future<bool> insertRecord(Map<String, dynamic> data) async {
    print("Waiting for database...");

    final db = await DBHelper.getDatabase();
    try {
      final int insertResult = await db.insert(db_table, data);
      if (insertResult > 0) {
        print("Record inserted successfully!");
        return true;
      } else {
        print("Failed to insert record.");
        return false;
      }
    } catch (e) {
      print("Error inserting record: $e");
      return false; 
    }
  }
}
