import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:my_evento/src/models/event_temporal_data_model.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';

import '../screens/my_home_screen.dart';

class TitleAndDescriptionScreenController extends ControllerMVC{

  late DataManager dataManager;
  late EventTemporalData eventTemporalData;
  //late TextEditingController titleEditingController;
  //late TextEditingController descriptionUpEditingController;

  late String valueTitle;
  late String valueDescription;

  TitleAndDescriptionScreenController._privateConstruct(this.dataManager);

  static final TitleAndDescriptionScreenController _instance = TitleAndDescriptionScreenController._privateConstruct(DataManager());

  factory TitleAndDescriptionScreenController(){
    return _instance;
  }

  @override
  void initState(){
    //titleEditingController = TextEditingController();
    //descriptionUpEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    //titleEditingController.dispose();
    //descriptionUpEditingController.dispose();
    //eventTemporalData;
    super.dispose();
  }

  onPressedBack(context){
    return Navigator.pop(context);
  }

  onPressedFollowing(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => CreateEventScreen(eventTemporalData: eventTemporalData,))
    );
  }

  onPressedCancel(context){
    return Navigator.pop(context, MaterialPageRoute(
        builder: (context) => const MyHomeScreen(null))
    );
  }

  setEventTemporalData(setEventTemporalData){
    eventTemporalData = setEventTemporalData;
  }

  TextEditingController getTitleEditingController(){
    return eventTemporalData.title;
  }

  TextEditingController getDescriptionUpEditingController(){
    return eventTemporalData.description;
  }

  void onSubmittedTitle(String value){
    valueTitle = value;
  }

  void onSubmittedDescription(String value){
    valueDescription = value;
  }
//No se usa
  String getTitle(){
    return eventTemporalData.title.text;
  }
//No se usa
  String getDescriptionUp(){
    return eventTemporalData.description.text;
  }
}