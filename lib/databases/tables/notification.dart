import '../../databases/db_base.dart';

class DBNotificationTable extends DBBaseTable {
  @override
  var db_table = 'notification';

  static String sql_code = '''
   
   CREATE TABLE notification (
        notif_id INTEGER PRIMARY KEY AUTOINCREMENT,
        sender_id INTEGER,
        receiver_id INTEGER,
        message TEXT,
        status TEXT CHECK(status IN ('read', 'unread')),
        action TEXT CHECK(action IN ('accept', 'decline', 'null')),
        date_sent DATE
    );
    ''';
}
