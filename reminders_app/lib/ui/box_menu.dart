import 'package:flutter/material.dart';
import 'package:reminders_app/ui/theme.dart';

class BoxMenu extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const BoxMenu({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 104,
        width: 312,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color1, Color2],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}
