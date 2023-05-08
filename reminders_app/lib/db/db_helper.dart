import 'package:reminders_app/models/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int version = 1;
  static final String tabName = 'reminder';

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
          print('CREATING A NEW ONE');
          return db.execute(
            "CREATE TABLE $tabName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING, note TEXT, date STRING,"
            "startTime STRING, endTime STRING,"
            "remind INTEGER, repeat STRING,"
            "color INTEGER, isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Reminder? reminder) async {
    print('insert func called');
    return await _db?.insert(tabName, reminder!.toJson()) ?? 1;
  }
}
