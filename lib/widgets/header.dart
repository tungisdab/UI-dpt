import 'package:flutter/material.dart';
import 'package:web/styles/web_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return WebColor()
            .gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        'Videos',
        style: TextStyle(fontSize: 50, color: Colors.white),
      ));
  }
}