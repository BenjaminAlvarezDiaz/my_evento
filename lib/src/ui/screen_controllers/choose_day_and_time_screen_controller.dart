import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/title_and_description_screen.dart';

import '../../interfaces/i_view_controller.dart';
import '../../managers/data_manager.dart';
import '../../utils/screen_args.dart';
import '../screens/create_event_screen.dart';
import '../screens/my_home_screen.dart';

class ChooseDayAndTimeScreenController extends ControllerMVC implements IViewController{
  late DataManager dataManager;
  static late ChooseDayAndTimeScreenController _this;
  ChooseDayAndTimeScreenController._privateConstruct(this.dataManager);
  static final ChooseDayAndTimeScreenController _instance = ChooseDayAndTimeScreenController._privateConstruct(DataManager());

  factory ChooseDayAndTimeScreenController(ScreenArgs? args){
    _this = ChooseDayAndTimeScreenController._(args);
    return _instance;
  }

  static ChooseDayAndTimeScreenController get con => _this;
  ScreenArgs? args;
  ChooseDayAndTimeScreenController._(this.args);

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  initScreen({ScreenArgs? arguments}) {}

  @override
  disposeScreen() {}

  closeDataBase(){
    return DataManager().closeDataBase();
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
    return Navigator.pop(context, MaterialPageRoute(
        builder: (context) => const MyHomeScreen(null))
    );
  }
}