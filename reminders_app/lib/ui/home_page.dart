import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/ui/box_menu.dart';
import 'package:reminders_app/ui/reminder_page.dart';
import 'package:reminders_app/ui/theme.dart';
import '../services/themeServices.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _welcoming(),
          const SizedBox(
            height: 24,
          ),
          _dateBox(),
          BoxMenu(
            title: 'Reminders',
            onTap: () => Get.to(ReminderPage()),
          ),
          BoxMenu(
            title: 'Note',
            onTap: () => null,
          ),
          BoxMenu(
            title: 'Recomendation',
            onTap: () => null,
          ),
        ],
      ),
    );
  }

  _dateBox() {
    return Center(
      child: Container(
        height: 148,
        width: 330,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color1, Color2],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 120,
                width: 140,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'No Reminders today',
                    style: subHeading,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 140,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.MMM().format(DateTime.now()),
                      style: subHeading,
                    ),
                    Text(
                      DateFormat('dd').format(DateTime.now()),
                      style: dateheading,
                    ),
                    Text(
                      DateFormat.EEEE().format(DateTime.now()),
                      style: subHeading,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _welcoming() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 24,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi //Username',
              style: heading,
            ),
            Text(
              'how are you today?',
              style: subHeading,
            ),
            Text(
              "let’s see your remainder now",
              style: subHeading,
            )
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 20,
          // color: Get.isDarkMode ? Colors.white : Colors.black,
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
