import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../databases/tables/admin.dart';
import '../databases/tables/campaign.dart';
import '../databases/tables/contact.dart';
import '../databases/tables/notification.dart';
import '../databases/tables/organization_apply.dart';
import '../databases/tables/organization.dart';
import '../databases/tables/participant.dart';
import '../databases/tables/social_media.dart';
import '../databases/tables/user_donation.dart';

class DBHelper {
  static const _database_name = "donate.db";
  static const _database_version = 4;
  static var database;

  static List<String> sql_codes = [
    DBAdminTable.sql_code,
    DBCampaignTable.sql_code,
    DBContactTable.sql_code,
    DBNotificationTable.sql_code,
    DBOrganization_applyTable.sql_code,
    DBOrganizationTable.sql_code,
    DBParticipantTable.sql_code,
    DBSocial_mediaTable.sql_code,
    DBUser_donationTable.sql_code,
  ];

  static Future<Database> getDatabase() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    if (database != null) {
      return database;
    }

    database = await openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (db, version) async {
        for (var item in sql_codes) {
          try {
            await db.execute(item);
            print("Table created successfully with SQL: $item");
          } catch (e) {
            print("Error creating table with SQL: $item\nError: $e");
          }
        }
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrade logic if needed
      },
    );
    return database;
  }

  static Future<bool> databaseExists() async {
    final path = join(await getDatabasesPath(), _database_name);
    print("Database path: ${await getDatabasesPath()}");
    return await File(path).exists();
  }

  static Future<void> closeDatabase() async {
    if (database != null) {
      await database.close();
      database = null;
    }
  }

  static Future<void> backupDatabase(String backupPath) async {
    final path = join(await getDatabasesPath(), _database_name);
    final backupFile = File(backupPath);
    await File(path).copy(backupFile.path);
  }

  static Future<void> restoreDatabase(String backupPath) async {
    final path = join(await getDatabasesPath(), _database_name);
    await File(backupPath).copy(path);
  }

  static Future<void> deleteDatabaseFile() async {
    final path = join(await getDatabasesPath(), _database_name);
    if (await File(path).exists()) {
      await File(path).delete();
    }
  }

  /// Fetch all table names in the database
  static Future<List<String>> getTables() async {
    try {
      final db = await getDatabase();
      var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table';"
      );
      return result.map((e) => e['name'] as String).toList();
    } catch (e) {
      print("Error fetching table names: $e");
      return [];
    }
  }

  /// Check if a specific table exists
  static Future<bool> isTableExists(String tableName) async {
    try {
      final db = await getDatabase();
      var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?;",
        [tableName]
      );
      return result.isNotEmpty;
    } catch (e) {
      print("Error checking table $tableName: $e");
      return false;
    }
  }
  
}
 
 