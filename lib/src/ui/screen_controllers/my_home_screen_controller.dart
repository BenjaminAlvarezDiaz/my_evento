import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/choose_date_screen.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';
import 'package:my_evento/src/ui/screens/my_home_screen.dart';
import 'package:my_evento/src/managers/data_manager.dart';
import 'package:my_evento/src/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:my_evento/src/utils/page_args.dart';
import '../../interfaces/i_view_controller.dart';

class MyHomeScreenController extends ControllerMVC implements IViewController{
  late List<Event> events;
  late DataManager dataManager;
  static late MyHomeScreenController _this;
  MyHomeScreenController._privateConstruct(this.dataManager);
  static final MyHomeScreenController _instance = MyHomeScreenController._privateConstruct(DataManager());

  factory MyHomeScreenController(PageArgs? args){
    _this = MyHomeScreenController._(args);
    return _instance;
  }

  static MyHomeScreenController get con => _this;
  PageArgs? args;
  MyHomeScreenController._(this.args);

  @override
  void initState(){
    super.initState();
    //getTitleEvent();
  }

  @override
  initScreen({PageArgs? arguments}) {}

  @override
  disposeScreen() {}

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
        builder: (context) => const ChooseDateScreen())
    );
  }
}