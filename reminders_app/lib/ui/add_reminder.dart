import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/controllers/reminderController.dart';
// import 'package:reminders_app/controllers/reminders_controller.dart';
import 'package:reminders_app/models/reminder.dart';
import 'package:reminders_app/ui/button.dart';
import 'package:reminders_app/ui/text_field.dart';
import 'package:reminders_app/ui/theme.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final ReminderController _reminderController = Get.put(ReminderController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String endTime = DateFormat("kk:mm").format(DateTime.now()).toString();
  String startTime = DateFormat("kk:mm").format(DateTime.now()).toString();
  int addremind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String addrepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int colorpicker = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: heading,
              ),
              MyTextField(
                title: 'Title',
                hint: 'Enter title here',
                controller: titleController,
              ),
              MyTextField(
                  title: 'Note',
                  hint: 'Enter your note',
                  controller: noteController),
              MyTextField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                      onPressed: () {
                        _getCalendar();
                      },
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ))),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      title: 'Start Time',
                      hint: startTime,
                      widget: IconButton(
                          onPressed: () {
                            _getTime(isStartTime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: MyTextField(
                      title: 'End Time',
                      hint: endTime,
                      widget: IconButton(
                          onPressed: () {
                            _getTime(isStartTime: false);
                          },
                          icon: const Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ],
              ),
              MyTextField(
                  title: 'Remind me before',
                  hint: '$addremind minutes early',
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0),
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                          style: Get.isDarkMode
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        addremind = int.parse(newValue!);
                      });
                    },
                  )),
              MyTextField(
                  title: 'Remind me before',
                  hint: addrepeat,
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0),
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                          style: Get.isDarkMode
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        addrepeat = newValue!;
                      });
                    },
                  )),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPicker(),
                  Button(label: 'Create Task', onTap: () => _validateDate())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      //add to database

      _addtoDB();
      Get.back();
      Get.snackbar('Reminder added', 'Reminder added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.green,
          icon: const Icon(
            Icons.add_task_rounded,
            color: Colors.green,
          ));
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar('Required', 'All fileds are required !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ));
    }
  }

  _addtoDB() async {
    int value = await _reminderController.addReminder(
        reminder: Reminder(
            note: noteController.text,
            title: titleController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: startTime,
            endTime: endTime,
            remind: addremind,
            repeat: addrepeat,
            color: colorpicker,
            isComplete: 0));
    print('My id is' + '$value');
  }

  _colorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: titleStyle),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  colorpicker = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? Colors.blue
                      : index == 1
                          ? Colors.red
                          : Colors.yellow,
                  child: colorpicker == index
                      ? const Icon(Icons.done, color: Colors.white, size: 16)
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
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

  _getCalendar() async {
    DateTime? _datepicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2034));

    if (_datepicker != null) {
      setState(() {
        _selectedDate = _datepicker;
      });
    }
  }

  _getTime({required bool isStartTime}) async {
    var timePicker = await _showTimePicker();
    String timeFormat = timePicker.format(context);
    if (timePicker == null) {
    } else if (isStartTime == true) {
      setState(() {
        startTime = timeFormat;
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = timeFormat;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(':')[0]),
            minute: int.parse(startTime.split(':')[1].split(' ')[0])));
  }
}
