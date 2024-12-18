import '../../databases/db_base.dart';

class DBOrganization_applyTable extends DBBaseTable {
  @override
  var db_table = 'organization_apply';

  static String sql_code = '''
   
    CREATE TABLE organization_apply (
        organization_apply_id INTEGER PRIMARY KEY AUTOINCREMENT,
        organization_id INTEGER,
        FOREIGN KEY (organization_id) REFERENCES Organization(organization_id)
    );
    ''';
}
