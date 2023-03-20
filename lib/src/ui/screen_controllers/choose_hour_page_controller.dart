import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/create_event_page.dart';
import 'package:my_evento/src/ui/screens/my_home_page.dart';

class ChooseHourPageController extends ControllerMVC{
  ChooseHourPageController._privateConstruct();

  static final ChooseHourPageController _instance = ChooseHourPageController._privateConstruct();

  factory ChooseHourPageController(){
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
        builder: (context) => const CreateEventPage())
    );
  }

  onPressedCancel(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const MyHomePage())
    );
  }
}