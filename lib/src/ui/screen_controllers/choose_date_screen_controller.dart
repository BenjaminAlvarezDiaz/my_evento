import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/choose_hour_screen.dart';
import 'package:my_evento/src/ui/screens/my_home_screen.dart';
import 'package:path/path.dart';

class ChooseDateScreenController extends ControllerMVC{
  ChooseDateScreenController._privateConstruct();

  static final ChooseDateScreenController _instance = ChooseDateScreenController._privateConstruct();

  factory ChooseDateScreenController(){
    return _instance;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void disponse(){
    super.dispose();
  }

  onPressedBack(context){
    return Navigator.pop(context);
  }

  onPressedFollowing(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const ChooseHourScreen())
    );
  }

  onPressedCancel(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const MyHomeScreen(null))
    );
  }
}