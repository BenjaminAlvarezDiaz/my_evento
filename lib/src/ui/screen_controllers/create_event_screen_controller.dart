import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';
import 'package:my_evento/src/managers/data_manager.dart';

class CreateEventScreenController extends ControllerMVC{
  late DataManager dataManager;
  late TextEditingController textEditingController;
  late TextEditingController titleEditingController;
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
    textEditingController = TextEditingController();
    descriptionUpEditingController = TextEditingController();
    descriptionDownEditingController = TextEditingController();

  }

  @override
  void dispose() {
    textEditingController.dispose();
    descriptionUpEditingController.dispose();
    descriptionDownEditingController.dispose();
    super.dispose();
  }

  TextEditingController getTitleEditingController(){
    titleEditingController = TextEditingController();
    return titleEditingController;
  }

  TextEditingController getDescriptionUpEditingController(){
    descriptionUpEditingController = TextEditingController();
    return descriptionUpEditingController;
  }

  TextEditingController getDescriptionDownEditingController(){
    descriptionDownEditingController = TextEditingController();
    return descriptionDownEditingController;
  }

  void onSubmittedTitle(String value){
    valueTitle = value;
  }

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