import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/ui/add_reminder.dart';
import 'package:reminders_app/ui/button.dart';
import 'package:reminders_app/ui/detail_reminder.dart';
import 'package:reminders_app/ui/task_tile.dart';
import 'package:reminders_app/ui/theme.dart';
import '../controllers/reminderController.dart';
import '../models/reminder.dart';
import '../services/notif_services.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final ReminderController reminderController = ReminderController();
  List<Reminder> _reminders = [];
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    loadReminders();
  }

  void loadReminders() async {
    final List<Reminder> reminders = await reminderController.getReminders();
    setState(() {
      _reminders = reminders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTask(),
          _dateBar(),
          const SizedBox(
            height: 10,
          ),
          _reminderlist(),
        ],
      ),
    );
  }

  _reminderlist() {
    loadReminders();
    return Expanded(
      child: ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (BuildContext context, int index) {
          final Reminder reminder = _reminders[index];

          if (reminder.repeat == 'Daily') {
            DateTime date =
                DateFormat.jm().parse(reminder.startTime.toString());
            var myTime = DateFormat('hh:mm', 'id_ID').format(date);
            notifyHelper.scheduledNotification(
                hour: int.parse(myTime.toString().split(':')[0]),
                minutes:
                    int.parse(myTime.toString().split(':')[1].split(' ')[0]),
                reminder: reminder);

            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Row(
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          Get.to(DetailReminderPage(reminder: reminder));
                        },
                        onTap: () {
                          _showBottomSheed(context, reminder);
                        },
                        child: ReminderTile(reminder),
                      )
                    ],
                  )),
                ));
          }
          if (reminder.date == DateFormat.yMd().format(_selectedDate)) {
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheed(context, reminder);
                        },
                        child: ReminderTile(reminder),
                      )
                    ],
                  )),
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _showBottomSheed(BuildContext context, Reminder reminder) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: reminder.isComplete == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          reminder.isComplete == 1
              ? Container()
              : _bottomSheetButton(
                  label: 'Task Completed',
                  onTap: () {
                    ReminderController.markCompleted(reminder.id!);
                    loadReminders();
                    Get.back();
                  },
                  clr: Colors.lightBlue,
                  context: context),
          _bottomSheetButton(
              label: 'Delete Reminder',
              onTap: () {
                ReminderController.delete(reminder);
                loadReminders();
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              label: 'Close',
              onTap: () {
                Get.back();
              },
              clr: Colors.red,
              context: context),
          SizedBox(height: 10)
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(label,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white))),
      ),
    );
  }

  _dateBar() {
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
          setState(() {
            _selectedDate = date;
          });
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
                loadReminders();
                await Get.to(() => const AddTask());

                reminderController.getReminders();
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
    );
  }
}
