import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/ui/box_menu.dart';
import 'package:reminders_app/ui/reminder_page.dart';
import 'package:reminders_app/ui/theme.dart';
import '../services/notif_services.dart';
import '../services/themeServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    super.initState();
  }

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
            onTap: () async {
              await Get.to(ReminderPage());
            },
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
                    style: subHeading.copyWith(color: Colors.black),
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
                      style: subHeading.copyWith(color: Colors.black),
                    ),
                    Text(
                      DateFormat('dd').format(DateTime.now()),
                      style: dateheading.copyWith(color: Colors.black),
                    ),
                    Text(
                      DateFormat.EEEE().format(DateTime.now()),
                      style: subHeading.copyWith(color: Colors.black),
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
        onTap: () async {
          await notifyHelper.displayNotification(
              title: 'Theme Change',
              body: Get.isDarkMode
                  ? 'Activate Light Theme'
                  : 'Activated Dark Theme');
          ThemeServices().switchTheme();

          //notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 20,
          // color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
