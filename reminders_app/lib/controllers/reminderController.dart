import 'package:get/get.dart';
import 'package:reminders_app/db/db_helper.dart';
import 'package:reminders_app/models/reminder.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addReminder({Reminder? reminder}) async {
    return await DBHelper.insert(reminder);
  }
}
