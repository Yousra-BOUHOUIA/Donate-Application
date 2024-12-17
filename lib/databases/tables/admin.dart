import '../../databases/db_base.dart';
class DBAdminTable extends DBBaseTable {
  @override
  var db_table = 'admin';
  
  static String sql_code = '''
   
    CREATE TABLE admin (
        admin_id INTEGER PRIMARY KEY,
        organization_apply_id INTEGER,
        contact_message_id INTEGER,
        FOREIGN KEY (organization_apply_id) REFERENCES Organization_Apply(organization_apply_id),
        FOREIGN KEY (contact_message_id) REFERENCES Contact(contact_id)
    );
    ''';
}
