import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/screens/create_event_screen.dart';

import '../screens/my_home_screen.dart';

class TitleAndDescriptionScreenController extends ControllerMVC{

  late DataManager dataManager;
  late TextEditingController titleEditingController;
  late TextEditingController descriptionUpEditingController;

  late String valueTitle;
  late String valueDescription;

  TitleAndDescriptionScreenController._privateConstruct(this.dataManager);

  static final TitleAndDescriptionScreenController _instance = TitleAndDescriptionScreenController._privateConstruct(DataManager());

  factory TitleAndDescriptionScreenController(){
    return _instance;
  }

  @override
  void initState(){
    titleEditingController = TextEditingController();
    descriptionUpEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    titleEditingController.dispose();
    descriptionUpEditingController.dispose();
    super.dispose();
  }

  onPressedBack(context){
    return Navigator.pop(context);
  }

  onPressedFollowing(context){
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => CreateEventScreen(titleEditingController: titleEditingController, descriptionEditingController: descriptionUpEditingController,))
    );
  }

  onPressedCancel(context){
    return Navigator.pop(context, MaterialPageRoute(
        builder: (context) => const MyHomeScreen(null))
    );
  }

  TextEditingController getTitleEditingController(){
    return titleEditingController;
  }

  TextEditingController getDescriptionUpEditingController(){
    return descriptionUpEditingController;
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
}