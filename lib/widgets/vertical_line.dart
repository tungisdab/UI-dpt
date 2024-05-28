import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:web/styles/web_colors.dart';

class VerticalLine extends StatelessWidget {
  const VerticalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.vertical,
      lineLength: 1500,
      dashColor: WebColor.textColor,
      lineThickness: 2,
      dashLength: 20,
      dashGapLength: 20,
      dashGradient: [Colors.red, Colors.blue],
      dashGapRadius: 4,
    );
  }
}
