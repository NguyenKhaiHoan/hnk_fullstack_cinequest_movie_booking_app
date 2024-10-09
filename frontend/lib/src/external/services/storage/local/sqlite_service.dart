import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Sqlite service
class SqliteService {
  static Database? _database;

  /// Khởi tạo database
  static Future<void> initializeDatabase(
    String dbName,
    Future<void> Function(Database, int)? createDatabase,
  ) async {
    // if (_database != null) {
    //   await _database!.close();
    // }
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$dbName.db';
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: createDatabase,
    );
  }

  Database get database {
    if (_database == null) {
      throw Exception('Database has not been initialized'.hardcoded);
    }
    return _database!;
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    _database = database;
    return _database!.insert(table, data);
  }

  Future<int> updateData(
    String table,
    Map<String, dynamic> data,
    String where,
    List<dynamic> whereArgs,
  ) async {
    _database = database;
    return _database!.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> deleteData(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    _database = database;
    return _database!.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> queryData(
    String table, {
    String? orderBy,
  }) async {
    _database = database;
    return _database!.query(table, orderBy: orderBy);
  }

  Future<void> clear() async {
    _database = database;
    await _database!.close();
  }
}
