import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/managers/data_manager.dart';
import 'package:flutter/material.dart';

class TitleAndDescriptionScreenController extends ControllerMVC{

  late DataManager dataManager;

  TitleAndDescriptionScreenController._privateConstruct(this.dataManager);

  static final TitleAndDescriptionScreenController _instance = TitleAndDescriptionScreenController._privateConstruct(DataManager());

  factory TitleAndDescriptionScreenController(){
    return _instance;
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  onPressedBack(context){
    return Navigator.pop(context);
  }
}