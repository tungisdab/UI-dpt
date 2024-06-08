import 'package:flutter/material.dart';
import 'package:web/styles/web_colors.dart';

class Refresh extends StatelessWidget {
  const Refresh({super.key});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(WebColor.buttonColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
          fixedSize: MaterialStateProperty.all(
              Size(170, 50)), // Đặt kích thước cố định
          elevation: MaterialStateProperty.all(5), // Độ cao của nút
          shadowColor: MaterialStateProperty.all(Colors.grey), // Màu bóng đổ
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bo tròn góc nút
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red.withOpacity(0.2); // Màu khi nhấn
              }
              return null; // Sử dụng màu mặc định cho các trạng thái khác
            },
          ),
        ),
        onPressed: () {
          // setState(() {});
        },
        label: Text(
          'Top Video',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: Image.asset(
          'assets/icons/vid.png',
          fit: BoxFit.cover,
          height: 25,
          width: 25,
        ),
      );
  }
}