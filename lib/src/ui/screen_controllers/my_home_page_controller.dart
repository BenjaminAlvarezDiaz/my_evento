import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/choose_date_page.dart';
import 'package:my_evento/src/ui/screens/create_event_page.dart';
import 'package:my_evento/src/ui/screens/my_home_page.dart';
import 'package:my_evento/src/managers/data_manager.dart';
import 'package:my_evento/src/models/event_model.dart';
import 'package:flutter/material.dart';

class MyHomePageController extends ControllerMVC{
  late List<Event> events;
  late DataManager dataManager;
  MyHomePageController._privateConstruct(this.dataManager);
  static final MyHomePageController _instance = MyHomePageController._privateConstruct(DataManager());

  factory MyHomePageController(){
    return _instance;
  }

  @override
  void initState(){
    super.initState();
    //getTitleEvent();
  }

  getListEvents(){
    return dataManager.getListEvent();
  }

  closeDataBase(){
    return dataManager.closeDataBase();
  }

  /*getTitleEvent(){
    return dataManager.getTitleEvent();
  }*/

  getListEvent(){
    return dataManager.getListEvent();
  }

  onPressedCreateEvent(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const ChooseDatePage())
    );
  }
}