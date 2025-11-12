import 'package:flutter/material.dart';
import 'package:kickngoal/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KickNGoal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFDCEDC8),
          secondary: const Color(0xFFFFF9C4),
        ),
      ),
      home: MyHomePage(),
    );
  }
}