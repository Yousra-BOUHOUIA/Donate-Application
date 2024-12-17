import 'package:donate_application/databases/tables/user.dart';
import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';
import '../db_helper.dart';

class DBParticipantTable extends DBBaseTable {
  @override
  final String db_table = 'participant';

  static const String sql_code = '''
    CREATE TABLE participant (
        participant_id INTEGER PRIMARY KEY,
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
        FOREIGN KEY (card_id) REFERENCES Card(card_id)
    );
    ''';

  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      // Validate participant-specific fields
      if (!data.containsKey('full_name') || !data.containsKey('email')) {
        throw Exception('Missing required fields: email or full_name.');
      }

      // Insert into `user` table first
      final userTable = DBUserTable();
      final userData = {
        'email': data['email'],
        'password': data['password'],
     
      };
      bool userInserted = await userTable.insertRecord(userData);
      if (!userInserted) {
        throw Exception('Failed to insert into user table.');
      }

      // Insert into `participant` table
      final database = await DBHelper.getDatabase();
      await database.insert(db_table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e, stacktrace) {
      print('Error inserting into $db_table: $e --> $stacktrace');
    }
    return false;
  }
}
