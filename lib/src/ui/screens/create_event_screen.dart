import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/models/event_temporal_data_model.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';
import 'package:my_evento/src/ui/screen_controllers/create_event_screen_controller.dart';
import 'package:my_evento/values/k_colors.dart';
import 'package:image_picker/image_picker.dart';

import '../popups/select_image_popup.dart';

class CreateEventScreen extends StatefulWidget {
  final EventTemporalData eventTemporalData;
  const CreateEventScreen({Key? key, required this.eventTemporalData}) : super(key: key);

  @override
  StateMVC<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends StateMVC<CreateEventScreen> {
  late CreateEventScreenController _con;
  late TextEditingController _textEditingController;
  String displayTextTitle = "";
  String displayTextDescriptionUp = "";
  String displayTextDescriptionDown = "";
  File? image;
  File imageDefault = File('assets/FkhJZuIWIAALYHi.jpg');
  File? photo;

  _CreateEventScreenState() : super (CreateEventScreenController()) {
    _con = CreateEventScreenController();
  }

  @override
  void initState() {
    super.initState();
    _con.setEventTemporalData(widget.eventTemporalData);
  }

  String formatHour(int dateTime) {
    if(dateTime == 24){
      return '00';
    }
    String date = dateTime.toString().padLeft(2, '0');
    return date;
  }

  String formatDate(int dateTime){
    String date = dateTime.toString().padLeft(2, '0');
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhite,
      extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: body(),
      
    );
  }

  AppBar appBar(context){
    return AppBar(
      backgroundColor: KTransparent,
      leading: IconButton(
          onPressed: (){
            _con.onPressedBack(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: KPrimary,
          )
      ),
      elevation: 0.0,
    );
  }

  Widget body(){
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                _con.onUploadImage(context);
                },
              child: _con.getImage() != null? Image.file(_con.getImage()!, fit: BoxFit.cover, height: 400,) :
              Container(
                color: KGrey5,
                height: 400,
                child: const Center(
                  child: Icon(Icons.image, size: 40, color: KSecondary),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(flex: 6, child: SizedBox(width: 20, child: title(_con.getTitleEditingController()),)),
                      SizedBox(width: 20,),
                      Text('${formatDate(_con.getDateTime().day)}'
                          '/${formatDate(_con.getDateTime().month)}'
                          ' de ${formatHour(_con.getStartTime().hour)}:${formatHour(_con.getStartTime().minute)}'
                          ' a ${formatHour(_con.getEndTime().hour)}:${formatHour(_con.getEndTime().minute)}',
                          style: const TextStyle(color: KGrey2),
                      ),
                      SizedBox(width: 10,),
                      editButton()
                    ],
                  ),
                ),
                description(_con.getDescriptionEditingController()),
                const SizedBox(height: 200,),
                //description(_con.getDescriptionDownEditingController()),
                //const SizedBox(height: 10,),
                button(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget title(TextEditingController? textEditingController){
    return TextField(
      controller: textEditingController,
      /*onSubmitted: (String value){
                      _con.onSubmittedTitle(value);
                    },*/
      strutStyle: StrutStyle(),
      style: TextStyle(fontSize: 18),
      maxLines: 1,
      textAlignVertical: TextAlignVertical.top,
      cursorColor: KPrimary,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: KSecondary, width: 1.5)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: KSecondary_L1.withOpacity(0.5), width: 1.5)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)),
          hintText: 'Titulo evento',
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
    );
  }

  Widget description(TextEditingController? textEditingController){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        controller: textEditingController,
        /*onSubmitted: (String value){
          _con.onSubmittedDescription(value);
          },*/
        maxLines: null,
        minLines: 10,
        strutStyle: StrutStyle(),
        style: TextStyle(fontSize: 16,),
        cursorColor: KPrimary,
        decoration: InputDecoration(
            isDense: true,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: KSecondary, width: 1.5)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: KSecondary_L1.withOpacity(0.5), width: 1.5)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
            hintText: 'Descripción',
            contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget editButton(){
    return InkWell(
      onTap: (){
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: KSecondary_L1,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Icon(Icons.edit, size: 14, color: KWhite,),),
      ),
    );
  }

  Widget button(){
    return InkWell(
      onTap: (){
        setState((){
          /*displayTextTitle = _con.getTitle();
          displayTextDescriptionUp = _con.getDescriptionUp();
          displayTextDescriptionDown = _con.getDescriptionDown();
          print(displayTextTitle);
          print(displayTextDescriptionUp);
          print(displayTextDescriptionDown);*/
        });
        //print(_con.getTitle());
        //print(_con.getDescription());



      },
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            color:KWhite,
            //boxShadow: [BoxShadow(color: Colors.black, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3))]
        ),
        child: Padding(padding: const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 20),
          child: Container(
            color: KPrimary,
            child: Center(
              child: Text(
                'Crear evento',
                style: TextStyle(color: KWhite, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget bottomSheet(){
    return BottomSheet(onClosing: (){}, builder: (BuildContext) => Container(color: KRed, height: 200,)
    );
  }
  
}
