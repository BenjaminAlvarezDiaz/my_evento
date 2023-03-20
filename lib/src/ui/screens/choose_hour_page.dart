import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_hour_page_controller.dart';

class ChooseHourPage extends StatefulWidget {
  const ChooseHourPage({Key? key}) : super(key: key);

  @override
  StateMVC<ChooseHourPage> createState() => _ChooseHourPageState();
}

class _ChooseHourPageState extends StateMVC<ChooseHourPage> {
  late ChooseHourPageController _con;

  _ChooseHourPageState() : super(ChooseHourPageController()){
    _con = ChooseHourPageController();
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
