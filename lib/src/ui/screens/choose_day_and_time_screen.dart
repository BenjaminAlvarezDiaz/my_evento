import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_day_and_time_screen_controller.dart';
import '../../../values/k_colors.dart';
import '../../utils/screen_args.dart';

class ChooseDayAndTimeScreen extends StatefulWidget {
  final ScreenArgs? args;
  const ChooseDayAndTimeScreen(this.args, {super.key});

  @override
  StateMVC<ChooseDayAndTimeScreen> createState() => _ChooseDayAndTimeScreenState(this.args);
}

class _ChooseDayAndTimeScreenState extends StateMVC<ChooseDayAndTimeScreen> {
  late ChooseDayAndTimeScreenController _con;
  ScreenArgs? args;

  _ChooseDayAndTimeScreenState(ScreenArgs? arguments) : super (ChooseDayAndTimeScreenController(arguments)) {
    _con = ChooseDayAndTimeScreenController.con;
    args = arguments;
  }

  @override
  void initState(){
    _con.initScreen(arguments: args);
    super.initState();
  }

  @override
  void dispose(){
    //_con.closeDataBase();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar(){
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

  Widget body() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            dropdownMenu('Elija día del evento: '),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: dropdownMenu('Desde: '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: dropdownMenu('Hasta: '),
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownMenu(String title){
    DateTime initialDate = DateTime.now();
    List <DropdownMenuItem> items = [
      DropdownMenuItem(
          child: CalendarDatePicker(
              initialDate: initialDate,
              firstDate: initialDate,
              lastDate: initialDate,
              onDateChanged: (date){}
          )
      )
    ];

    List <DropdownMenuItem> item = [
      DropdownMenuItem(child: Text('a'))
    ];
    return Column(
      children: [
        Text(title),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            items: item,
          ),
        ),
      ],
    );
  }

  Widget buttons(IconData? iconLeft, String textContent, IconData? iconRight){
    return Container(
      child: Row(
        children: [
          IconButton(icon: Icon(iconLeft), onPressed: (){},),
          Text(textContent),
          IconButton(icon: Icon(iconRight), onPressed: (){},),
        ],
      ),
    );
  }
}
