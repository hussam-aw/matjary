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
        createTableQueries.map((query) async => await db.execute(query));
      },
    );
  }

  Future<dynamic> getData(tableName) async {
    var dbClient = await database;
    List<dynamic> maps =
        await dbClient?.query(tableName) as List<Map<dynamic, dynamic>>;
    print(maps);
    return maps;
  }

  Future<void> insert(table, row) async {
    var dbClient = await database;
    try {
      await dbClient?.insert(
        table,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Inserted');
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(table, id) async {
    var dbClient = await database;
    try {
      dbClient?.delete(table, where: 'id=?', whereArgs: [id]);
      print('Deleted');
    } catch (e) {
      print(e);
    }
  }
}
