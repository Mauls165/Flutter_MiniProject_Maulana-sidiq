import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:reminders_app/controllers/reminders_controller.dart';
import 'package:reminders_app/ui/add_reminder.dart';
import 'package:reminders_app/ui/button.dart';
import 'package:reminders_app/ui/theme.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  // final _reminderController = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTask(),
          _dateBar(),
          // _remindercard(),
        ],
      ),
    );
  }

  // _remindercard() {
  //   return Expanded(child: Obx(() {
  //     return ListView.builder(
  //         itemCount: _reminderController.remindList.length,
  //         itemBuilder: (_, index) {
  //           print(_reminderController.remindList.length);
  //           return Container(
  //             width: 100,
  //             height: 50,
  //             color: Colors.green,
  //             margin: const EdgeInsets.only(bottom: 10),
  //             child:
  //                 Text(_reminderController.remindList[index].title.toString()),
  //           );
  //         });
  //   }));
  // }

  _dateBar() {
    DateTime _selectedDate = DateTime.now();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: DatePicker(
        height: 100,
        width: 80,
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.lightBlue,
        selectedTextColor: Colors.white,
        dayTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        dateTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTask() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeading),
                Text('Today', style: heading)
              ],
            ),
          ),
          Button(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => const AddTask());
                // _reminderController.getReminders();
              })
        ],
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 20,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
