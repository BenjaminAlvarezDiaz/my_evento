import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/models/event_temporal_data_model.dart';
import 'package:my_evento/src/ui/screens/title_and_description_screen.dart';

import '../../interfaces/i_view_controller.dart';
import '../../managers/data_manager.dart';
import '../../utils/screen_args.dart';
import '../screens/create_event_screen.dart';
import '../screens/my_home_screen.dart';

class ChooseDayAndTimeScreenController extends ControllerMVC implements IViewController{
  late DataManager dataManager;
  DateTime dateTime = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  XFile image = XFile('assets/FkhJZuIWIAALYHi.jpg');
  late EventTemporalData eventTemporalData;
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
  initScreen({ScreenArgs? arguments}) {
    eventTemporalData = EventTemporalData(
        dateTime: dateTime,
        startTime: startTime,
        endTime: endTime,
        title: title,
        description: description,
        image: image
    );
  }

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
        builder: (context) => TitleAndDescriptionScreen(eventTemporalData: eventTemporalData,))
    );
  }

  onPressedCancel(context){
    return Navigator.pop(context, MaterialPageRoute(
        builder: (context) => const MyHomeScreen(null))
    );
  }

  DateTime getDateTime(){
    return eventTemporalData.dateTime;
  }

  DateTime getStartTime(){
    return eventTemporalData.startTime;
  }

  DateTime getEndTime(){
    return eventTemporalData.endTime;
  }
}