import 'package:donate_application/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';

class DBOrganizationTable extends DBBaseTable {
  @override
  final String db_table = 'organization';

  static const String sql_code = '''
    CREATE TABLE organization (
        organization_id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT,
        contact_id INTEGER,
        social_media_id INTEGER,
        notif_id INTEGER,
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
        FOREIGN KEY (card_id) REFERENCES Card(card_id),
         FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
    );
    ''';

  @override
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      // Insert organization data directly
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
