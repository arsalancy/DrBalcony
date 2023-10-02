import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  DBHelper.internal();

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'drbalcony.db');

    // Create the database and table
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE projects (
          id INTEGER ,
          filepath TEXT,
          isSent INTEGER
        )
      ''');
    });
  }
  //PRIMARY KEY

  Future<int> insertProject(int id, String filepath, int isSent) async {
    final dbClient = await db;
    final values = {
      'id': id,
      'filepath': filepath,
      'isSent': isSent,
    };
    return await dbClient.insert('projects', values);
  }

  Future<List<Map<String, dynamic>>> getAllProjects() async {
    final dbClient = await db;
    return await dbClient.query('projects');
  }

  Future<List<Map<String, dynamic>>> isthereSubmitid(int id) async {
    final dbClient = await db;
    return await dbClient.query('projects', columns: ["id"], whereArgs: [id]);
  }

  Future<int> updateProject(int id, int isSent) async {
    final dbClient = await db;
    final values = {
      'isSent': isSent,
    };
    return await dbClient
        .update('projects', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteProject(int id) async {
    final dbClient = await db;
    return await dbClient.delete('projects', where: 'id = ?', whereArgs: [id]);
  }
}
