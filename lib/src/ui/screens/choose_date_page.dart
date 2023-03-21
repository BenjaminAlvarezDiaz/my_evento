import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/calendar_picker.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_date_page_controller.dart';

class ChooseDatePage extends StatefulWidget {
  const ChooseDatePage({Key? key}) : super(key: key);

  @override
  StateMVC<ChooseDatePage> createState() => _ChooseDatePageState();
}

class _ChooseDatePageState extends StateMVC<ChooseDatePage> {
  late ChooseDatePageController _con;

  _ChooseDatePageState() : super (ChooseDatePageController()){
    _con = ChooseDatePageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  AppBar appBar(context){
    return AppBar(
      backgroundColor: const Color(0xff7F0432),
      leading: IconButton(
          onPressed: (){
            _con.onPressedBack(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
      ),
    );
  }

  Widget body(context){
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(2023 + 20);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10,),
          Text('Elija día del evento:', style: TextStyle(fontSize: 20, color: Colors.black),),
          const CalendarPicker(
            enabledAllDaysOfMonth: false,
            daysWithBorder: false,
            nameDaysWithBorder: false,
            fontWeightOfNameDay: FontWeight.w500,
            fontWeightOfDay: FontWeight.normal,
            fontWeightOfMonth: FontWeight.w500,
          ),
          cancelAndNext(context)
        ],
      ),
    );
  }

  Widget cancelAndNext(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonMultifunction(
            text: const Text('Cancelar', style: TextStyle(fontSize: 20, color: Color(0xff7F0432)),),
            withIcon: true,
            iconRight: true,
            width: 200,
            backgroundColor: Colors.white,
            icon: const Icon(Icons.clear, color: Color(0xffEB1B1B), size: 30,),
            onTap: (){
              _con.onPressedCancel(context);
            }
        ),
        ButtonMultifunction(
            text: const Text('Siguiente', style: TextStyle(fontSize: 20, color: Color(0xff00001D)),),
            withIcon: true,
            iconRight: true,
            width: 200,
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check, color: Color(0xff1B8023), size: 30,),
            onTap: (){
              _con.onPressedFollowing(context);
            }
        ),
      ],
    );
  }
}
