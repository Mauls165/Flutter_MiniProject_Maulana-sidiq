import 'dart:async';
import 'package:path/path.dart';
import 'package:reminders_app/models/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;
  static const String tabName = 'reminder';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'reminder.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tabName(
            id INTEGER PRIMARY KEY,
            title TEXT,
            note TEXT,
            isComplete INTEGER,
            date TEXT,
            startTime TEXT,
            endTime TEXT,
            color INTEGER,
            remind INTEGER,
            repeat TEXT
          )
        ''');
      },
    );
  }

  static delete(Reminder reminder) async {
    await _db!.delete(tabName, where: 'id=?', whereArgs: [reminder.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE reminder
      SET isComplete = ?
      WHERE id = ?
''', [1, id]);
  }
}
