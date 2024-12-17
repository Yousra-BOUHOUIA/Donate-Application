import '../../databases/db_base.dart';

class DBSocial_mediaTable extends DBBaseTable {
  @override
  var db_table = 'social_media';
  
  static String sql_code = '''
    CREATE TABLE social_media (
        social_media_id INTEGER PRIMARY KEY,
        platform TEXT,
        url_path TEXT
    );
    ''';
}