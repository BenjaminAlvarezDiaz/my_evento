import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screens/create_event_page.dart';
import 'package:my_evento/src/managers/data_manager.dart';

class CreateEventPageController extends ControllerMVC{
  late DataManager dataManager;
  late TextEditingController textEditingController;
  late TextEditingController titleEditingController;
  late TextEditingController descriptionUpEditingController;
  late TextEditingController descriptionDownEditingController;
  late String valueTitle;
  late String valueDescription;

  CreateEventPageController._privateConstruct(this.dataManager);

  static final CreateEventPageController _instance = CreateEventPageController._privateConstruct(DataManager());

  factory CreateEventPageController(){
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