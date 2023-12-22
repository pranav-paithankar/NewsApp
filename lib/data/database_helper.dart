// data/database_helper.dart
import 'dart:async';
import 'package:news_portal/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
      onDowngrade: _downgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        identifier TEXT,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    // BREAKING CHANGE: Handle breaking changes in the database schema here, if needed
  }

  Future<void> _downgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    // Handle database downgrades here, if needed
  }

  Future<int> insertUser(User user) async {
    try {
      final Database db = await database;
      return await db.insert('users', user.toMap());
    } catch (e) {
      print('Error inserting user: $e');
      return -1; // Return a specific value to indicate failure
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('users');

      // Convert the List<Map<String, dynamic>> to List<User>
      return List.generate(maps.length, (i) {
        return User(
          id: maps[i]['id'] as int?,
          identifier: maps[i]['identifier'] as String,
          username: maps[i]['username'] as String? ?? "",
          password: maps[i]['password'] as String,
        );
      });
    } catch (e) {
      print('Error retrieving users: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }
}
