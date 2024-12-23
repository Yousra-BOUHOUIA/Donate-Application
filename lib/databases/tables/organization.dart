import '../../databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';


class DBOrganizationTable{

  final String db_table = 'organization';

  static const String sql_code = '''
    CREATE TABLE organization (
        organization_id INTEGER PRIMARY KEY AUTOINCREMENT,
        organization_name TEXT,
        phone_num INT,
        address TEXT,
        money_transaction TEXT,
        bank_account INT,
        organization_type TEXT,
        social_media TEXT,
        email TEXT,
        uploaded_file TEXT,
        password TEXT
    );
  ''';

Future<int> insertOrganization(Map<String, dynamic> data) async {
  print("waiting getdatabase");

  final db = await DBHelper.getDatabase();
  
  bool tableExists = await DBHelper.isTableExists('organization');
  if (!tableExists) {
    print("Table 'organization' does not exist!");
    print("SQL for creating table: ${DBOrganizationTable.sql_code}");

    try {
      print("Creating 'organization' table...");
      await db.execute(DBOrganizationTable.sql_code); 
      print("Table 'organization' created successfully.");
    } catch (e) {
      print("Error creating table: $e");
      return -1; 
    }
  }
  
  print("waiting insert");
  return await db.insert('organization', data);
}



Future<Map<String, dynamic>?> getRecord(String column, dynamic id,
      {String? condition, List<dynamic>? conditionArgs}) async {
    try {
      final database = await DBHelper.getDatabase();
      String whereClause = "$column = ?";
      List<dynamic> whereArgs = [id];

      if (condition != null && conditionArgs != null) {
        whereClause = "$whereClause AND $condition";
        whereArgs.addAll(conditionArgs);
      }

      var result = await database.query(
        db_table,
        where: whereClause,
        whereArgs: whereArgs,
        limit: 1,
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e, stacktrace) {
      print('Error retrieving from $db_table: $e --> $stacktrace');
    }
    return null;
  }

  Future<String> getPasswordById(int organizationId) async {
    final db = await DBHelper.getDatabase();

    List<Map<String, dynamic>> result = await db.query(
      'organization', 
      columns: ['password'],
      where: 'organization_id = ?',
      whereArgs: [organizationId],
    );

    if (result.isNotEmpty) {
      return result.first['password'] as String;
    } else {
      throw Exception("Organization not found");
    }
  }


  Future<bool> updateRecord(
      Map<String, dynamic> data, String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      await database.update(
        db_table,
        data,
        where: "$column = ?",
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e, stacktrace) {
      print('Error updating $db_table: $e --> $stacktrace');
    }
    return false;
  }

  Future<bool> deleteRecord(String column, dynamic id) async {
    try {
      final database = await DBHelper.getDatabase();
      int count = await database.delete(
        db_table,
        where: "$column = ?",
        whereArgs: [id],
      );
      return count > 0;
    } catch (e, stacktrace) {
      print('Error deleting from $db_table: $e --> $stacktrace');
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getAllRecords() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(db_table);
    } catch (e, stacktrace) {
      print('Error fetching records from $db_table: $e --> $stacktrace');
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> getDonations() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        db_table,
        where: "type = ?",
        whereArgs: ['donation'],
      );
    } catch (e, stacktrace) {
      print('Error fetching donations from $db_table: $e --> $stacktrace');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        db_table,
        where: "type = ?",
        whereArgs: ['event'],
      );
    } catch (e, stacktrace) {
      print('Error fetching events from $db_table: $e --> $stacktrace');
      return [];
    }
  }
}
