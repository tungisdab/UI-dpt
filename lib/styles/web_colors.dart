import 'package:flutter/material.dart';

class WebColor {
  static Color textColor = Color.fromARGB(255, 104, 40, 40);
  static Color buttonColor = Color.fromARGB(255, 237, 236, 236);
  static Color text = Color.fromARGB(255, 208, 62, 62);

  final gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      const Color.fromARGB(255, 247, 71, 58),
      const Color(0xFFF06292),
      const Color(0xFFF09868),
    ],
    tileMode: TileMode.mirror,
  );
}