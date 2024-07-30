import 'package:motorbikes_rent/utils/Database/migrations/create_tables.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';

class DBUtil {
  static Future<sql.Database> db() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'mtr.db'),
      onCreate: (db, version) async {
        await db.execute(createRentalTable);
        await db.execute(createMotorbikeTable);
      },
      version: 1,
    );
  }

  static Future<void> upsert(String table, Map<String, Object> data) async {
    final db = await DBUtil.db();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(
      {required String table, String? where}) async {
    final db = await DBUtil.db();
    return db.query(table, where: where);
  }
}
