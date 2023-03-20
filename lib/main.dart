import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/screens/my_home_page.dart';
import 'package:my_evento/src/ui/screens/my_home_demo_one.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff7F0432),
        secondaryHeaderColor: const Color(0xff231142)
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


