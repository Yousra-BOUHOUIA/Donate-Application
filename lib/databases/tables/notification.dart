import 'package:sqflite/sqflite.dart';
import '../../databases/db_base.dart';
import '../db_helper.dart';

class DBNotificationTable extends DBBaseTable {
  @override
  var db_table = 'notification';

  static String sql_code = '''
    CREATE TABLE notification (
        notif_id INTEGER PRIMARY KEY AUTOINCREMENT,
        participant_id INTEGER,
        receiver_id INTEGER,
        message TEXT,
        status TEXT CHECK(status IN ('read', 'unread')) DEFAULT 'unread',
        action TEXT CHECK(action IN ('accept', 'decline', 'null')) DEFAULT 'null',
        date_sent DATE DEFAULT (datetime('now', 'localtime'))
    );
  ''';



  /// Fetch notifications with sender's username
  Future<List<Map<String, dynamic>>> fetchNotificationsWithSenderName() async {
    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT n.notif_id, n.participant_id, n.message, p.name
      FROM notification n
      LEFT JOIN participant p ON n.participant_id = p.participant_id
    ''');
    return results;
  }

  /// Insert a new notification
  Future<void> insertNotification(int senderId, int receiverId, String message) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.insert(
        db_table,
        {
          'participant_id': senderId,
          'receiver_id': receiverId,
          'message': message,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Notification inserted successfully!");
    } catch (e) {
      print("Error inserting notification: $e");
    }
  }

  /// Mark a notification as read
  Future<void> markNotificationAsRead(int notifId) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.update(
        db_table,
        {'status': 'read'},
        where: 'notif_id = ?',
        whereArgs: [notifId],
      );
      print("Notification marked as read.");
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }
Future<void> dropTable() async {
    try {
      final db = await DBHelper.getDatabase();
      await db.execute('DROP TABLE IF EXISTS $db_table');
      print("Table '$db_table' dropped successfully.");
    } catch (e) {
      print("Error dropping table '$db_table': $e");
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(int notifId) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.delete(
        db_table,
        where: 'notif_id = ?',
        whereArgs: [notifId],
      );
      print("Notification deleted successfully.");
    } catch (e) {
      print("Error deleting notification: $e");
    }
  }

  /// Fetch all unread notifications
  Future<List<Map<String, dynamic>>> fetchUnreadNotifications() async {
    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> results = await db.query(
      db_table,
      where: "status = ?",
      whereArgs: ['unread'],
    );
    return results;
  }
}
