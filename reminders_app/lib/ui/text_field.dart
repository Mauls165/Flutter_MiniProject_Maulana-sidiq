import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminders_app/ui/theme.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  final TextEditingController? controller;
  const MyTextField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                readOnly: widget == null ? false : true,
                autofocus: false,
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                controller: controller,
                style: subtitleStyle,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtitleStyle,
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),
              )),
              widget == null ? Container() : Container(child: widget)
            ]),
          ),
        ],
      ),
    );
  }
}
