import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/insect_model.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bugfinder.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        email TEXT UNIQUE,
        password TEXT NOT NULL
      )
    ''');


    await db.execute('''
      CREATE TABLE insects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        imageUrl TEXT,
        scientificName TEXT,
        activeTime TEXT,
        location TEXT,
        dangerous INTEGER,
        diet TEXT,
        lastSeenTime TEXT,
        insectType TEXT,
        flowerPreference TEXT,
        lifespan TEXT,
        frequency TEXT,
        activityPeriod TEXT,
        abilities TEXT,
        size REAL,
        regions TEXT,
        FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
  }


  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE insects ADD COLUMN insectType TEXT;');
      await db.execute('ALTER TABLE insects ADD COLUMN flowerPreference TEXT;');
      await db.execute('ALTER TABLE insects ADD COLUMN lifespan TEXT;');
      await db.execute('ALTER TABLE insects ADD COLUMN frequency TEXT;');
      await db.execute('ALTER TABLE insects ADD COLUMN activityPeriod TEXT;');
      await db.execute('ALTER TABLE insects ADD COLUMN abilities TEXT;');
      await db.execute('ALTER TABLE insects ADD COLUMN size REAL;');
      await db.execute('ALTER TABLE insects ADD COLUMN regions TEXT;');


      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT UNIQUE NOT NULL,
          email TEXT UNIQUE,
          password TEXT NOT NULL
        )
      ''');
    }

    if (oldVersion < 3) {
      try {
        await db.execute('ALTER TABLE users ADD COLUMN email TEXT UNIQUE;');
      } catch (_) {}
    }


    if (oldVersion < 4) {
      try {
        await db.execute('ALTER TABLE insects ADD COLUMN userId INTEGER NOT NULL DEFAULT 0;');
      } catch (_) {}
    }
  }

  Future<int> addInsect(InsectModel insect) async {
    final db = await instance.database;
    return await db.insert('insects', insect.toMap());
  }

  Future<List<InsectModel>> getInsectsByUser(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      'insects',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'lastSeenTime DESC',
    );
    return result.map((json) => InsectModel.fromJson(json)).toList();
  }

  Future<void> deleteInsect(int id) async {
    final db = await instance.database;
    await db.delete('insects', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> registerUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> getUser(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  Future<bool> isUsernameTaken(String username) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'username = ?', whereArgs: [username]);
    return result.isNotEmpty;
  }

  Future<bool> isEmailTaken(String email) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty;
  }
}
