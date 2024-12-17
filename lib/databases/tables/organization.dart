import 'package:donate_application/databases/tables/user.dart';
import 'package:donate_application/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';

class DBOrganizationTable extends DBBaseTable {
  @override
  final String db_table = 'organization';

  static const String sql_code = '''
    CREATE TABLE organization (
        organization_id INTEGER PRIMARY KEY,
        social_media_id INTEGER,
        notif_id INTEGER,
        card_id INTEGER,
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
        FOREIGN KEY (card_id) REFERENCES Card(card_id)
    );
    ''';

  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      // Validate organization-specific fields
      if (!data.containsKey('organization_name') ||
          !data.containsKey('email')) {
        throw Exception('Missing required fields: email or organization_name.');
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

      // Insert into `organization` table
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
