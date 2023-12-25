import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_evento/src/ui/screens/my_home_screen.dart';
import 'package:my_evento/src/ui/screens/my_home_demo_one.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';
import 'package:my_evento/values/k_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(MYsystemTheme);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: KBackgroundColor,
        primaryColor: const Color(0xff7F0432),
        secondaryHeaderColor: const Color(0xff231142)
      ),
      home: const MyHomeScreen(null),
      debugShowCheckedModeBanner: false,
    );
  }
}


