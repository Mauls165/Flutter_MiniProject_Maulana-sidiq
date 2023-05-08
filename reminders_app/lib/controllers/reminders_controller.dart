import 'package:get/get.dart';
import 'package:reminders_app/dp/dp_helper.dart';
import 'package:reminders_app/models/reminder.dart';

class ReminderController extends GetxController {
  void onRead() {
    super.onReady();
  }

  var remindList = <Reminder>[].obs;

  Future<int> addReminder({Reminder? reminder}) async {
    return await DBHelper.insert(reminder);
  }

  // void getReminders() async {
  //   List<Map<String, dynamic>> task = await DBHelper.query();
  //   remindList.assignAll(task.map((data) => Reminder.fromJson(data)).toList());
  // }
}
