import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:reminders_app/ui/theme.dart';

import '../models/reminder.dart';

class DetailReminderPage extends StatelessWidget {
  final Reminder reminder;

  DetailReminderPage({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Reminder',
              style: heading,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _boxDetail(title: 'Title', hint: reminder.title),
                      _boxDetail(title: 'Note', hint: reminder.note),
                      _boxDetail(title: 'Date', hint: reminder.date),
                      _boxDetail(title: 'Start Time', hint: reminder.startTime),
                      _boxDetail(title: 'End Time', hint: reminder.endTime),
                      _boxDetail(
                          title: 'Remind', hint: reminder.remind.toString()),
                      _boxDetail(title: 'Repeat', hint: reminder.repeat),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _getBGClr(reminder.color ?? 0),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default:
        return Colors.lightBlue;
    }
  }

  _boxDetail({required title, required hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              hint,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
