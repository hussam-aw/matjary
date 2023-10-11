import 'package:matjary/Constants/app_strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), appDatabaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(createTableQueries[0]);
        await db.execute(createTableQueries[1]);
        await db.execute(createTableQueries[2]);
        await db.execute(createTableQueries[3]);
        await db.execute(createTableQueries[4]);
        await db.execute(createTableQueries[5]);
      },
    );
  }

  Future<dynamic> getAllTableData(tableName) async {
    var dbClient = await database;
    List<dynamic> maps =
        await dbClient?.query(tableName) as List<Map<dynamic, dynamic>>;
    print(maps);
    return maps.reversed;
  }

  Future<dynamic> getData(tableName, column, args) async {
    var dbClient = await database;
    List<dynamic> maps = await dbClient?.query(
      tableName,
      where: "$column IN (?, ?)",
      whereArgs: args,
    ) as List<Map<dynamic, dynamic>>;
    print(maps);
    return maps.reversed;
  }

  Future<bool> insert(table, row) async {
    var dbClient = await database;
    try {
      int id = await dbClient!.insert(
        table,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print(id);
      return true;
    } catch (e) {
      print('catch erro ' + e.toString());
      return false;
    }
  }

  Future<bool> update(table, row, id) async {
    var dbClient = await database;
    try {
      int count =
          await dbClient!.update(table, row, where: '$id=?', whereArgs: [id]);
      if (count > 0) {
        print('Updated');
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> delete(table, column, args) async {
    var dbClient = await database;
    try {
      int rows = await dbClient!.delete(
        table,
        where: "$column IN (?, ?)",
        whereArgs: args,
      );
      if (rows > 0) {
        print('Deleted');
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> clearTable(String tableName) async {
    var dbClient = await database;
    await dbClient!.rawDelete('DELETE FROM $tableName');
  }
}
