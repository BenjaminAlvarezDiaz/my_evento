import 'package:flutter/material.dart';
import 'package:my_evento/src/models/event_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../managers/data_manager.dart';

class EventScreenController extends ControllerMVC{
  late DataManager dataManager;
  late Event eventData;

  EventScreenController._privateConstruct(this.dataManager);

  static final EventScreenController _instance = EventScreenController._privateConstruct(DataManager());

  factory EventScreenController(){
    return _instance;
  }

  setEventData(setEventData){
    eventData = setEventData;
  }

  String getTitle(){
    return eventData.eventTitle;
  }

  String getDescription(){
    return eventData.description;
  }

  String getImage(){
    return eventData.image;
  }

  DateTime getDateTime(){
    return eventData.date;
  }

  String getStartTime(){
    return eventData.startHour;
  }

  String getEndTime(){
    return eventData.endHour;
  }


  onPressedBack(context){
    return Navigator.pop(context);
  }
}