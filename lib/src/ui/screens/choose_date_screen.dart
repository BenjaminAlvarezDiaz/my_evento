import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/calendar_picker.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_date_screen_controller.dart';
import 'package:my_evento/values/k_colors.dart';

class ChooseDateScreen extends StatefulWidget {
  const ChooseDateScreen({Key? key}) : super(key: key);

  @override
  StateMVC<ChooseDateScreen> createState() => _ChooseDateScreenState();
}


class _ChooseDateScreenState extends StateMVC<ChooseDateScreen> {
  late ChooseDateScreenController _con;
  late int daySelected = 0;
  //late CalendarPicker calendarPicker;

  _ChooseDateScreenState() : super (ChooseDateScreenController()){
    _con = ChooseDateScreenController();
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

  Widget body(context){
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(2023 + 20);
    return Container(
      color: KWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10,),
          Text('Elija día del evento:', style: TextStyle(fontSize: 20, color: KDefault_Text),),
          CalendarPicker(
            enabledAllDaysOfMonth: false,
            daysWithBorder: false,
            nameDaysWithBorder: false,
            fontWeightOfNameDay: FontWeight.w500,
            fontWeightOfDay: FontWeight.normal,
            fontWeightOfMonth: FontWeight.w500,
            onDaySelected: (date){
              setState(() {
                daySelected = date.day;
                print(daySelected);
              });
            },
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
            text: const Text('Cancelar', style: TextStyle(fontSize: 20, color: KPrimary),),
            withIcon: true,
            iconRight: true,
            width: 200,
            backgroundColor: KWhite,
            icon: const Icon(Icons.clear, color: KCancel, size: 30,),
            onTap: (){
              _con.onPressedCancel(context);
              daySelected = 0;
              print(daySelected);
            }
        ),
        ButtonMultifunction(
            text: const Text('Siguiente', style: TextStyle(fontSize: 20, color: KSecondary_D1),),
            withIcon: true,
            iconRight: true,
            width: 200,
            backgroundColor: KWhite,
            icon: const Icon(Icons.check, color: KAccept, size: 30,),
            onTap: (){
              _con.onPressedFollowing(context);
              if(daySelected == 0){
                daySelected = DateTime.now().day;
              }
              print(daySelected);
            }
        ),
      ],
    );
  }
}
