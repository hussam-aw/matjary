import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MatjaryDatabaseHelper {
  MatjaryDatabaseHelper._();
  static final MatjaryDatabaseHelper db = MatjaryDatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "MegaStoreDatabase.db");
  }
}
