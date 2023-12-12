import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/models/event_temporal_data_model.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';
import 'package:my_evento/src/ui/screen_controllers/title_and_description_screen_controller.dart';
import 'package:my_evento/values/k_colors.dart';

import '../components/button_multifunction_component.dart';

class TitleAndDescriptionScreen extends StatefulWidget {
  final EventTemporalData eventTemporalData;
  const TitleAndDescriptionScreen({super.key, required this.eventTemporalData});

  @override
  StateMVC<TitleAndDescriptionScreen> createState() => _TitleAndDescriptionScreenState();
}

class _TitleAndDescriptionScreenState extends StateMVC<TitleAndDescriptionScreen> {
  late TitleAndDescriptionScreenController _con;

  _TitleAndDescriptionScreenState() : super(TitleAndDescriptionScreenController()){
    _con = TitleAndDescriptionScreenController();
  }

  @override
  void initState(){
    _con.setEventTemporalData(widget.eventTemporalData);
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(),
    );
  }

  AppBar appBar(context){
    return AppBar(
      backgroundColor: KPrimary,
      leading: IconButton(
          onPressed: (){
            _con.onPressedBack(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: KWhite,
          )
      ),
    );
  }

  Widget body(){
    return Container(
      color: KTransparent,
      child: Center(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                title(_con.getTitleEditingController()),
                description(_con.getDescriptionUpEditingController()),
                SizedBox(height: 110,),
                buttons(),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title(TextEditingController? textEditingController){
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 200, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text('Titulo: ', textAlign: TextAlign.left, style: TextStyle(fontSize: 20),),
            ],
          ),
          TextField(
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
          ),
        ]
      ),
    );
  }

  Widget description(TextEditingController? textEditingController){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text('Descripción: ', textAlign: TextAlign.left, style: TextStyle(fontSize: 18),),
            ],
          ),
          TextField(
            controller: textEditingController,
            /*onSubmitted: (String value){
              _con.onSubmittedDescription(value);
              },*/
            maxLines: null,
            minLines: 14,
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
        ],
      ),
    );
  }

  Widget buttons (){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonMultifunction(
            text: Text('Cancelar', style: TextStyle(fontSize: 20, color: KDefault_Text),),
            onTap: (){
              _con.onPressedCancel(context);
            },
            withIcon: true,
            iconRight: true,
            width: 160,
            backgroundColor: KTransparent,
            icon: Icon(Icons.clear, color: KCancel, size: 30,),
          ),
          ButtonMultifunction(
            text: Text('Siguiente', style: TextStyle(fontSize: 20),),
            onTap: (){
              _con.onPressedFollowing(context);
            },
            withIcon: true,
            iconRight: true,
            width: 160,
            backgroundColor: KTransparent,
            icon: const Icon(Icons.check, color: KAccept, size: 30,),
          ),
        ],
      ),
    );
  }
}
