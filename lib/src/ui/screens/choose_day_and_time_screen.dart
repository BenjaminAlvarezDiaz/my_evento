import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/dropdown_component.dart';
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
            dropdownMenu('Elija día del evento: ', '09/08/2023'),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: dropdownMenu('Desde: ', '16:00'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: dropdownMenu('Hasta: ', '20:00'),
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownMenu(String title, String text){
    DateTime initialDate = DateTime.now();
    List <DropdownMenuItem> items = [
      DropdownMenuItem(
          child: CalendarDatePicker(
              initialDate: initialDate,
              firstDate: initialDate,
              lastDate: initialDate,
              onDateChanged: (date){}
          ),
        value: 1,
      )
    ];

    List <DropdownMenuItem> item = [
      const DropdownMenuItem(child: Text('a'), value: 1,),
      const DropdownMenuItem(child: Text('b'), value: 2,),
      const DropdownMenuItem(child: Text('b'), value: 3,),
    ];
    return Column(
      children: [
        Text(title),
        Dropdown(
            button: Container(
                color: Colors.deepPurple,
                child: const Text('Nouuuuuuuuuuuuuuuuuu')
            ),
            content: Container(
                color: Colors.pink,
                child: const Text('Siiuu'
                    '\nuuu\nuu'
                    '\'nuuu\nuuu'
                    '\nuuu\nuuu'
                    '\nuu\nuuuuu'
                    '\nuuuuuu\nuuuuu'
                    '\nuuuuuu\nuuuuu'
                    '\nuuuuuu\nuuuuu'
                    '\nuuuuuu\nuuuuu'
                    '\nuuuuuu\nuuuuu'
                    '\nuuuuuu\nuuuuu'
                )
            )
        ),
      ],
    );
  }

  Widget dropdownComponent(){
    return ButtonMultifunction(
        text: Text('a'),
        onTap: (){

        }
    );
  }

  Widget _dropDownMenu(){
    return Container(height: 500, width: 500, color: KRed,);
  }

  Widget dropdownOther(String text, items){
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: ButtonMultifunction(
          text: Text(text),
          onTap: (){},
        ),
        isExpanded: true,
        isDense: true,
        items: items,
        onChanged: (a){
          print(a);
        },
        onMenuStateChange: (a){
          print(a);
        },
        dropdownStyleData: DropdownStyleData(maxHeight: 400, width: 500),
        menuItemStyleData: MenuItemStyleData(height: 400),
      ),
    );
  }

  Widget dropdown(){
    List<DropdownMenuEntry> dropdownMenuEntries = [
      DropdownMenuEntry(value: 1, label: 'a'),
      DropdownMenuEntry(value: 2, label: 'b'),
      DropdownMenuEntry(value: 3, label: 'c'),
    ];
    return DropdownMenu(
        dropdownMenuEntries: dropdownMenuEntries
    );
  }

  Widget button(String text, IconData? iconLeft, iconRight){
    return Container(
      child: Row(
        children: [
          Icon(iconLeft),
          Text(text),
          Icon(iconRight),
        ],
      ),
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
