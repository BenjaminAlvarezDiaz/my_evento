import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/models/event_temporal_data_model.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';
import 'package:my_evento/src/managers/data_manager.dart';

class CreateEventScreenController extends ControllerMVC{
  late DataManager dataManager;
  late TextEditingController textEditingController;
  late TextEditingController titleEditingController;
  late TextEditingController descriptionEditingController;
  late DateTime dateTime;
  late DateTime startTime;
  late DateTime endTime;
  late EventTemporalData eventTemporalData;
  //late ImagePicker image;
  late TextEditingController descriptionUpEditingController;
  late TextEditingController descriptionDownEditingController;
  late String valueTitle;
  late String valueDescription;

  CreateEventScreenController._privateConstruct(this.dataManager);

  static final CreateEventScreenController _instance = CreateEventScreenController._privateConstruct(DataManager());

  factory CreateEventScreenController(){
    return _instance;
  }

  @override
  void initState() {
    super.initState();
    descriptionUpEditingController = TextEditingController();
    descriptionDownEditingController = TextEditingController();

  }

  @override
  void dispose() {
    descriptionUpEditingController.dispose();
    descriptionDownEditingController.dispose();
    eventTemporalData;
    super.dispose();
  }

  setTitleEditingController(setTitleEditingController){
    titleEditingController = setTitleEditingController;
  }

  setDescriptionEditingController(setDescriptionEditingController){
    descriptionEditingController = setDescriptionEditingController;
  }

  setEventTemporalData(setEventTemporalData){
    eventTemporalData = setEventTemporalData;
  }

  TextEditingController getTitleEditingController(){
    return eventTemporalData.title;
  }

  TextEditingController getDescriptionEditingController(){
    return eventTemporalData.description;
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

  ImagePicker? getImage(){
    return eventTemporalData.image;
  }

  TextEditingController getDescriptionUpEditingController(){
    descriptionUpEditingController = TextEditingController();
    return descriptionUpEditingController;
  }

  TextEditingController getDescriptionDownEditingController(){
    descriptionDownEditingController = TextEditingController();
    return descriptionDownEditingController;
  }

  //No se usa
  void onSubmittedTitle(String value){
    valueTitle = value;
  }

  //No se usa
  void onSubmittedDescription(String value){
    valueDescription = value;
  }

  String getTitle(){
    return titleEditingController.text;
  }

  String getDescriptionUp(){
    return descriptionUpEditingController.text;
  }

  String getDescriptionDown(){
    return descriptionDownEditingController.text;
  }

  onPressedBack(context){
    return Navigator.pop(context);
  }
}