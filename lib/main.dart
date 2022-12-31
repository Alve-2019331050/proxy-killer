import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/admin/home.dart';
import 'package:proxy_killer/screens/home/student/home.dart';
import 'package:proxy_killer/screens/home/teacher/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentHome(),
    );
  }
}