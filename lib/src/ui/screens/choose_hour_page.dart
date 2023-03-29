import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/hour_picker.dart';
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
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20,),
            Text('Desde: ', style: TextStyle(fontSize: 16),),
            HourPicker(),
            SizedBox(height: 20,),
            Text('Hasta: ', style: TextStyle(fontSize: 16),),
            HourPicker(),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonMultifunction(
                  text: Text('Cancelar', style: TextStyle(fontSize: 20),),
                  onTap: (){
                    _con.onPressedCancel(context);
                  },
                  withIcon: true,
                  iconRight: true,
                  width: 200,
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.clear, color: Color(0xffEB1B1B), size: 30,),
                ),
                ButtonMultifunction(
                  text: Text('Siguiente', style: TextStyle(fontSize: 20),),
                  onTap: (){
                    _con.onPressedFollowing(context);
                  },
                  withIcon: true,
                  iconRight: true,
                  width: 200,
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.check, color: Color(0xff1B8023), size: 30,),
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
