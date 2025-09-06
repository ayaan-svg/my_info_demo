import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'data.dart'; // Import your UserInfo class

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'user_info.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE personal_info(
        id INTEGER PRIMARY KEY,
        firstName TEXT,
        lastName TEXT,
        middleName TEXT,
        preferredName TEXT,
        fullName TEXT,
        jobTitle TEXT,
        profilePicture TEXT,
        workPhone TEXT,
        mobilePhone TEXT,
        workEmail TEXT,
        gender TEXT,
        dateOfBirth TEXT,
        maritalStatus TEXT,
        addressLine1 TEXT,
        city TEXT,
        state TEXT,
        zipCode TEXT
      )
    ''');
  }

  Future<int> insertInitialData(UserInfo userInfo) async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM personal_info'),
    );
    if (count == 0) {
      return await db.insert('personal_info', userInfo.toMap());
    }
    return 0;
  }

  Future<UserInfo?> getUserInfo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('personal_info');

    if (maps.isNotEmpty) {
      return UserInfo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUserInfo(UserInfo userInfo) async {
    final db = await database;
    return await db.update(
      'personal_info',
      userInfo.toMap(),
      where: 'id = ?',
      whereArgs: [userInfo.id],
    );
  }
}
