import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/choose_date_screen.dart';
import 'package:my_evento/src/ui/screens/choose_day_and_time_screen.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';
import 'package:my_evento/src/ui/screens/my_home_screen.dart';
import 'package:my_evento/src/managers/data_manager.dart';
import 'package:my_evento/src/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:my_evento/src/utils/screen_args.dart';
import '../../interfaces/i_view_controller.dart';
import '../screens/title_and_description_screen.dart';

class MyHomeScreenController extends ControllerMVC implements IViewController{
  late List<Event> events;
  late DataManager _dataManager;
  static late MyHomeScreenController _this;
  MyHomeScreenController._privateConstruct(this._dataManager);
  static final MyHomeScreenController _instance = MyHomeScreenController._privateConstruct(DataManager());

  factory MyHomeScreenController(ScreenArgs? args){
    _this = MyHomeScreenController._(args);
    return _instance;
  }

  static MyHomeScreenController get con => _this;
  ScreenArgs? args;
  MyHomeScreenController._(this.args);

  @override
  void initState(){
    _dataManager = DataManager();
    super.initState();
    //getTitleEvent();
  }

  @override
  initScreen({ScreenArgs? arguments}) {}

  @override
  disposeScreen() {}

  getListEvents(){
    return DataManager().getListEvent();
  }

  closeDataBase(){
    return DataManager().closeDataBase();
  }

  /*getTitleEvent(){
    return dataManager.getTitleEvent();
  }*/

  getListEvent(){
    return DataManager().getListEvent();
  }

  onPressedCreateEvent(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => const ChooseDayAndTimeScreen(null))
    );
  }
}