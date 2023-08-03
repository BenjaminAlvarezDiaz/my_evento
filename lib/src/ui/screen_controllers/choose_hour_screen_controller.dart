import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';
import 'package:my_evento/src/ui/screens/my_home_screen.dart';
import 'package:my_evento/src/ui/screens/title_and_description_screen.dart';

class ChooseHourScreenController extends ControllerMVC{
  ChooseHourScreenController._privateConstruct();

  static final ChooseHourScreenController _instance = ChooseHourScreenController._privateConstruct();

  factory ChooseHourScreenController(){
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
        builder: (context) => const TitleAndDescriptionScreen())
    );
  }

  onPressedCancel(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const MyHomeScreen(null))
    );
  }
}