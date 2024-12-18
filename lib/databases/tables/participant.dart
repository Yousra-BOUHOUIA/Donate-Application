import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';
import '../db_helper.dart';

class DBParticipantTable extends DBBaseTable {
  @override
  final String db_table = 'participant';

  static const String sql_code = '''
    CREATE TABLE participant (
        email TEXT,
        password TEXT,
        contact_id INTEGER,
        participant_id INTEGER PRIMARY KEY AUTOINCREMENT,
        notif_id INTEGER,
        card_id INTEGER,
        full_name TEXT,
        gender TEXT CHECK(gender IN ('female', 'male')),
        profession TEXT,
        date_of_birth DATE,
        phone_num TEXT,
        address TEXT,
        image BLOB,
        FOREIGN KEY (notif_id) REFERENCES Notification(notif_id),
        FOREIGN KEY (card_id) REFERENCES Card(card_id),
         FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
    );
    ''';
  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      // Insert participant data directly
      final database = await DBHelper.getDatabase();
      int rowId = await database.insert(
        db_table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return rowId > 0; // Return true if insertion was successful
    } catch (e, stacktrace) {
      print('Error inserting into $db_table: $e\nStackTrace: $stacktrace');
      return false;
    }
  }
}
