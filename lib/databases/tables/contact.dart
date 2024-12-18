import '../../databases/db_base.dart';

class DBContactTable extends DBBaseTable {
  @override
  var db_table = 'contact';

  static String sql_code = '''
    CREATE TABLE contact (
        contact_id INTEGER PRIMARY KEY AUTOINCREMENT,
        organization_id INTEGER,
        participant_id INTEGER,
        content TEXT,
        FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
        FOREIGN KEY (participant_id) REFERENCES Participant(participant_id),
        CHECK (organization_id IS NULL OR participant_id IS NULL)  
    );
    ''';
}
