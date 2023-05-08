import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color blueColor = Color(0xff4e5ae8);
// const primaryClr = blueColor;
Color Color1 = const Color.fromARGB(255, 0, 193, 254);
Color Color2 = const Color.fromARGB(255, 12, 254, 179);

class Themes {
  static final light = ThemeData(
      primaryColor: Colors.blue
      //primaryClr,
      ,
      brightness: Brightness.light);
  static final dark =
      ThemeData(primaryColor: Colors.amberAccent, brightness: Brightness.dark);
}

TextStyle get heading {
  return GoogleFonts.poppins(
      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24));
}

TextStyle get dateheading {
  return GoogleFonts.poppins(
      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36));
}

TextStyle get subHeading {
  return GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16));
}

TextStyle get titleStyle {
  return GoogleFonts.poppins(
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16));
}

TextStyle get subtitleStyle {
  return GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    // color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700]
  ));
}
