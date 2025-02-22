import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _instance = DbHelper._internal();
  Database? _database;

  DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    var dataBasePath = await getDatabasesPath();
    var path = join(dataBasePath, 'store.db');

    Database database = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('CREATE TABLE STORE(id INTEGER PRIMARY KEY, name TEXT)');
    }, version: 1);
    return database;
  }

  // insert data
  Future<void> insertData(String enteredName) async {
    final db = await _db;
    db?.insert('STORE', {'name': enteredName});
  }

  // get all data
  Future<List<Map<String, Object?>>?> getAllData() async {
    final db = await _db;

    List<Map<String, Object?>>? query = await db?.query('STORE');

    return query;
  }

  // delete
  Future<void> deleteData(int id) async {
    final db = await _db;
    await db?.delete('STORE', where: 'id = ?', whereArgs: [id]);
  }

  // update
  Future<void> updateData(int id, String name1) async {
    final db = await _db;
    await db?.update('STORE', {'name': name1}, where: 'id=?', whereArgs: [id]);
  }
}
