import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/views/home.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Video Recognition',
      color: Colors.red,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}