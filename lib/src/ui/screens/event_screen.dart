import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/models/event_model.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

import '../../../values/k_colors.dart';
import '../screen_controllers/event_screen_controller.dart';

class EventScreen extends StatefulWidget {
  final Event eventData;
  const EventScreen({Key? key, required this.eventData}) : super(key: key);

  @override
  StateMVC<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends StateMVC<EventScreen> {
  late EventScreenController _con;

  _EventScreenState() : super (EventScreenController()) {
    _con = EventScreenController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.setEventData(widget.eventData);
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
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(_con.getImage()), fit: BoxFit.cover)
              ),
            ),
            Column(
              children: [
                profileTitleDateAndShare(),
                peopleNotifiedAndLocation(),
                description(),
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

  Widget profileTitleDateAndShare(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          profile(),
          titleAndDate(),
          const Expanded(flex: 1, child: SizedBox(width: 10,)),
          Column(
            children: [
              GestureDetector(
                  onTap: (){},
                  child: const Icon(Icons.share, size: 26, color: KSecondary_L1,)
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }

  Widget profile(){
    return InkWell(
      onTap: (){
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: KPrimary_L1,
            borderRadius: BorderRadius.circular(20)
        ),
        child: const Center(child: Icon(Icons.person, size: 20, color: KWhite,),),
      ),
    );
  }

  Widget titleAndDate(){
    return Column(
      children: [
        Row(
          children: [
            Text(_con.getTitle(), style: TextStyle(fontSize: 18),),
            SizedBox(width: 110,)
          ],
        ),
        Row(
          children: [
            Text('${formatDate(_con.getDateTime().day)}'
                ' de Diciembre'
                ' ${_con.getStartTime()}:${_con.getStartTime()}'
                ' a ${_con.getEndTime()}:${_con.getEndTime()}',
              style: const TextStyle(color: KGrey2, fontSize: 12),
            ),
            const SizedBox(width: 10,),
          ],
        )
      ],
    );
  }

  Widget peopleNotifiedAndLocation(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: KPrimary_L1,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Icon(Icons.person, size: 14, color: KWhite,),),
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: KPrimary_L1,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Icon(Icons.person, size: 14, color: KWhite,),),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: KPrimary_L1,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Icon(Icons.person, size: 14, color: KWhite,),),
                  ),
                ),
                Positioned(
                  left: 30,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: KPrimary_L1,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Icon(Icons.person, size: 14, color: KWhite,),),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5,),
          const Text('+100 Personas notificadas', style: TextStyle(fontSize: 12, color: KGrey2),),
          const Expanded(flex: 1, child: SizedBox(width: 10,)),
          const Row(
            children: [
              Icon(Icons.location_on, color: KSecondary_L1, size: 14,),
              Text('Argentina, Salta', style: TextStyle(fontSize: 12, color: KGrey2),)
            ],
          )
        ],
      ),
    );
  }

  Widget description(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
      child: Text(_con.getDescription()),
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
            child: const Center(
              child: Text(
                'Notificame',
                style: TextStyle(color: KWhite, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
