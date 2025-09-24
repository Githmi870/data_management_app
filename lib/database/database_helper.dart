import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User (
        UserId INTEGER PRIMARY KEY AUTOINCREMENT,
        Username TEXT UNIQUE NOT NULL,
        Password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Response (
        ResponseID INTEGER PRIMARY KEY AUTOINCREMENT,
        FormId INTEGER,
        UserID INTEGER,
        ResponseStatus VARCHAR(50)
      )
    ''');

    await db.execute('''
      CREATE TABLE Question (
        QuestionID INTEGER PRIMARY KEY AUTOINCREMENT,
        QuestionText VARCHAR(50),
        QuestionType VARCHAR(50),
        FormId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Answer (
        AnswerID INTEGER PRIMARY KEY AUTOINCREMENT,
        AnswerText VARCHAR(50),
        QuestionID INTEGER,
        ResponseID INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Media (
        MediaId INTEGER PRIMARY KEY AUTOINCREMENT,
        AnswerID INTEGER,
        MediaName VARCHAR(50),
        MediaType VARCHAR(50),
        Extension VARCHAR(50),
        Location TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Choice (
        ChoiceId INTEGER PRIMARY KEY AUTOINCREMENT,
        ChoiceText VARCHAR(50)
      )
    ''');

    await db.execute('''
      CREATE TABLE Form (
        FormId INTEGER PRIMARY KEY AUTOINCREMENT,
        ProjectId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Project (
        ProjectId INTEGER PRIMARY KEY AUTOINCREMENT,
        ProjectName VARCHAR(50),
        StartedDate VARCHAR(50),
        ProjectTitle VARCHAR(50),
        ProjectDescription VARCHAR(50),
        ProjectStatus VARCHAR(50),
        SectorId INTEGER,
        UserId INTEGER,
        FinishedDate DATE
      )
    ''');

    await db.execute('''
      CREATE TABLE Department (
        DepartmentId INTEGER PRIMARY KEY AUTOINCREMENT,
        DepartmentName VARCHAR(50)
      )
    ''');

    await db.execute('''
      CREATE TABLE Sector (
        SectorID INTEGER PRIMARY KEY AUTOINCREMENT,
        DepartmentId INTEGER,
        SectorName VARCHAR(50)
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> update(String table, Map<String, dynamic> values,
      {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
