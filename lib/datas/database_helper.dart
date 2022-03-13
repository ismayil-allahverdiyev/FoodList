import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const _dbName = "data.db";

  static const String columnID = "ID";
  static const String columnName = "Name";
  static const String _tableName = "Answers";


  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if(_database!=null){
      return _database!;
    }
    _database = await initiateDatabase();
    return _database!;
  }

  initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version){
    return db.execute(
        '''
      CREATE TABLE $_tableName(
      $columnID INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL )
      
      '''
    );
  }

  Future<int> insert(Map<String, dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update (Map<String, dynamic> row) async{
    Database db = await instance.database;
    int id = row[columnID];
    return await db.update(_tableName, row, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> delete (int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnID = ?', whereArgs: [id]);
  }
}