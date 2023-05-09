import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../db/db_helper.dart';
import '../models/reminder.dart';

class ReminderController {
  Future<int> insertReminder(Reminder reminder) async {
    final Database db = await DatabaseHelper().db;
    return await db.insert('Reminder', reminder.toJson());
  }

  Future<List<Reminder>> getReminders() async {
    final Database db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> maps = await db.query('Reminder');
    return List.generate(maps.length, (i) {
      return Reminder.fromJson(maps[i]);
    });
  }

  static delete(Reminder reminder) {
    DatabaseHelper.delete(reminder);
  }

  static markCompleted(int id) async {
    await DatabaseHelper.update(id);
  }
}
