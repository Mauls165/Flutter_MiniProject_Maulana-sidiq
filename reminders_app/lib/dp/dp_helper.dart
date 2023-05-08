import 'package:reminders_app/models/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int version = 1;
  static final String _tabName = 'reminder';

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + 'reminder.db';
      _db = await openDatabase(
        path,
        version: version,
        onCreate: (db, version) {
          print('creating a new one');
          return db.execute(
            'CREATE TABLE $_tabName('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title STRING, note TEXT, date STRING.'
            'startTime STRING, endTime STRING,'
            'remind INTEGER, repeat STRING,'
            'color INTEGER,'
            'isCompleted INTEGER)',
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Reminder? reminder) async {
    print('insert funct called');
    return await _db?.insert(_tabName, reminder!.toJson()) ?? 1;
  }

  // static Future<List<Map<String, dynamic>>> query() async {
  //   print('query function called');
  //   return await _db!.query(_tabName);
  // }
}
