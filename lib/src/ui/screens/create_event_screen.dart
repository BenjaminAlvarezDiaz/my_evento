import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';
import 'package:my_evento/src/ui/screen_controllers/create_event_screen_controller.dart';
import 'package:my_evento/values/k_colors.dart';

class CreateEventScreen extends StatefulWidget {
  final TextEditingController titleEditingController;
  final TextEditingController descriptionEditingController;
  const CreateEventScreen({Key? key, required this.titleEditingController, required this.descriptionEditingController}) : super(key: key);

  @override
  StateMVC<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends StateMVC<CreateEventScreen> {
  late CreateEventScreenController _con;
  late TextEditingController _textEditingController;
  String displayTextTitle = "";
  String displayTextDescriptionUp = "";
  String displayTextDescriptionDown = "";

  _CreateEventScreenState() : super (CreateEventScreenController()) {
    _con = CreateEventScreenController();
  }

  @override
  void initState() {
    super.initState();
    _con.setTitleEditingController(widget.titleEditingController);
    _con.setDescriptionEditingController(widget.descriptionEditingController);
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
            Container(
              height: 400,
              decoration: const BoxDecoration(
                color: KWhite,
                image: DecorationImage(image: AssetImage('assets/FkhJZuIWIAALYHi.jpg'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 200, bottom: 10),
                  child: title(_con.getTitleEditingController()),
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
      decoration: InputDecoration(
          isDense: true,
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
        decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
            hintText: 'Descripción',
            contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget button(){
    return InkWell(
      onTap: (){
        setState((){
          displayTextTitle = _con.getTitle();
          displayTextDescriptionUp = _con.getDescriptionUp();
          displayTextDescriptionDown = _con.getDescriptionDown();
          print(displayTextTitle);
          print(displayTextDescriptionUp);
          print(displayTextDescriptionDown);
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
