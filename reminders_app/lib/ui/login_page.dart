import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reminders_app/ui/button.dart';
import 'package:reminders_app/ui/home_page.dart';
import 'package:reminders_app/ui/text_field.dart';
import 'package:reminders_app/ui/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: Container(
            height: 216,
            width: 234,
            decoration: BoxDecoration(color: Colors.amber),
            child: Column(
              children: [
                MyTextField(title: 'User Name', hint: 'User Name'),
                MyTextField(title: 'PassWord', hint: 'Password')
              ],
            )),
      ),
    );
  }
}
