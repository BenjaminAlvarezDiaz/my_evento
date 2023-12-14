import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/managers/screen_manager.dart';
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
  late File? imagePicker = null;
  late File? photoPicker = null;
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

  onUploadImage(context) async {
    await ScreenManager().openSelectedImagePopUp(
        context, 
        onTapLeft: (){pickPhoto(context);},
        onTapRight: (){pickImage(context);}
    );
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

  File? getImage(){
    return imagePicker;
  }

  File? getPhoto(){
    return photoPicker;
  }

  Future<void> pickPhoto(context) async {
    final ImagePicker selectedImage = ImagePicker();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    eventTemporalData.image = (await selectedImage.pickImage(source: ImageSource.camera))!;
    if(eventTemporalData.image != null){
      setState(() {
        photoPicker = File(eventTemporalData.image!.path);
        Navigator.pop(context);
      });
    }else{
      //print('NOOOOOOOOOOOOO');
      Navigator.pop(context);
    }
  }

  Future<void> pickImage(context) async {
    //print('NOOOOOOOOOOOOO');
    final ImagePicker selectedImage = ImagePicker();
    print('JAKSJDKAS');
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    eventTemporalData.image = await selectedImage.pickImage(source: ImageSource.gallery);
    print('Siuuuuuuuuu');
    if(eventTemporalData.image != null){
      setState(() {
        //print('NOOOOOOOOOOOOO');
        imagePicker = File(eventTemporalData.image!.path);
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
    }
  }

  onPressedBack(context){
    return Navigator.pop(context);
  }
}