import 'package:partwindows/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:partwindows/database/PartModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseVersion = 1;
  static const table = 'part';
  static const columnId = 'id';
  static const columnType = 'type';
  static const columnNumber = 'number';
  static const columnName = 'name';
  var Readpath;

  //singleton
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  // opens the database and creates it if db doesn't exist
  _initDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    final Readpath = prefs.getString('path2') ?? 0;
    String path = Readpath.toString();
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    print("Creating database: $path");
    await databaseFactory.openDatabase(path);
    await getApplicationDocumentsDirectory();

    return await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: _databaseVersion, onCreate: _onCreate));
  }

  // create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnNumber TEXT NOT NULL,
            $columnType TEXT NOT NULL
          );''');
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Part part) async {
    Database db = await instance.database;
    return await db.insert(
        table, {'name': part.name, 'type': part.type, 'number': part.number});
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRowsName(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%' or $columnNumber LIKE '%$name%'");
  }


  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Part part) async {
    Database db = await instance.database;
    var name = part.toMap()['name'];
    return await db.update(table, part.toMap(),
        where: '$columnName = ?', whereArgs: [name]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String name) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnName = ?', whereArgs: [name]);
  }

  Future<List<Map<String, dynamic>>> allrecords() async {
    Database db = await instance.database;
    return await db.query(table);
  }

}
