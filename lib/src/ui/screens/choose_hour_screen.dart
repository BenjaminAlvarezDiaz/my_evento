import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_hour_screen_controller.dart';

class ChooseHourScreen extends StatefulWidget {
  const ChooseHourScreen({Key? key}) : super(key: key);

  @override
  StateMVC<ChooseHourScreen> createState() => _ChooseHourScreenState();
}

class _ChooseHourScreenState extends StateMVC<ChooseHourScreen> {
  late ChooseHourScreenController _con;

  _ChooseHourScreenState() : super(ChooseHourScreenController()){
    _con = ChooseHourScreenController();
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

  Widget body(){
    return Container(color: Colors.blue,);
  }
}
