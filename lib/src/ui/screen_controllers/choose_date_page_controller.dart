import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/choose_hour_page.dart';
import 'package:my_evento/src/ui/screens/my_home_page.dart';
import 'package:path/path.dart';

class ChooseDatePageController extends ControllerMVC{
  ChooseDatePageController._privateConstruct();

  static final ChooseDatePageController _instance = ChooseDatePageController._privateConstruct();

  factory ChooseDatePageController(){
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
        builder: (context) => const ChooseHourPage())
    );
  }

  onPressedCancel(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const MyHomePage())
    );
  }
}