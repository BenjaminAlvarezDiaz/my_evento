import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinner_picker/flutter_spinner_picker.dart';
import 'package:flutter_spinner_time_picker/flutter_spinner_time_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
//import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/dropdown_component.dart';
import 'package:my_evento/src/ui/components/hour_picker_component.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_day_and_time_screen_controller.dart';
import '../../../values/k_colors.dart';
import '../../utils/screen_args.dart';
import '../components/my_behavior.dart';

class ChooseDayAndTimeScreen extends StatefulWidget {
  final ScreenArgs? args;
  const ChooseDayAndTimeScreen(this.args, {super.key});

  @override
  StateMVC<ChooseDayAndTimeScreen> createState() => _ChooseDayAndTimeScreenState(this.args);
}

class _ChooseDayAndTimeScreenState extends StateMVC<ChooseDayAndTimeScreen> {
  late ChooseDayAndTimeScreenController _con;
  bool isWidgetVisible = false;
  bool isEventDayVisible = false;
  bool isFromVisible = false;
  bool isToVisible = false;
  ScreenArgs? args;
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay timeTo = TimeOfDay.now();

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

  String formatDate(int dateTime) {
    if(dateTime == 24){
      return '00';
    }
    String date = dateTime.toString().padLeft(2, '0');
    return date;
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
    return Center(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 580,
              width: double.infinity,
              child: Stack(
                children: [
                  //Positioned(top: 150, child: Container(height: 100, width: 200 ,color: KRed,)),
                  //eventDayFromAndTo(250, isToVisible, KSecondary, context),
                  /*Positioned(
                      top: 90,
                      left: 160,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Hasta:', style: TextStyle(fontSize: 16, color: KGrey2),),
                              SizedBox(width: 100,)
                            ],
                          ),
                          SizedBox(height: 2,),
                          button(
                              text: '16:00',
                              fontSize: 16,
                              iconLeft: Icons.calendar_today,
                              iconRight: Icons.keyboard_arrow_down,
                              function: (){
                                setState(() {
                                  isToVisible = !isToVisible;
                                });
                              },
                              height: 40,
                              width: 140,
                              content: Container()
                          ),
                        ],
                      )
                  ),*/
                  //eventDayFromAndTo(150, isFromVisible, KBlack, context),
                  //eventDayFromAndTo(50, isEventDayVisible, KRed, context),
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10,),
                          Text('Elija día del evento:', style: TextStyle(fontSize: 20, color: KGrey2),),
                          SizedBox(width: 140,)
                        ],
                      ),
                      //Text('Elija día del evento:', style: TextStyle(fontSize: 20, color: KGrey2),),
                      const SizedBox(height: 5,),
                      button(
                          iconLeftFlex: 1,
                          iconRightFlex: 1,
                          textFlex: 6,
                          contentFlex: 3,
                          text:' ${formatDate(initialDate.day)}'
                               '/${formatDate(initialDate.month)}'
                               '/${formatDate(initialDate.year)}',
                          fontSize: 16,
                          iconLeft: Icons.calendar_today,
                          iconRight: Icons.keyboard_arrow_down,
                          function: (){
                            setState(() {
                              isEventDayVisible = !isEventDayVisible;
                            });
                          },
                        height: 40,
                        width: 300,
                        content: Container()
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Text('Desde:', style: TextStyle(fontSize: 16, color: KGrey2),),
                                  SizedBox(width: 95,)
                                ],
                              ),
                              SizedBox(height: 2,),
                              button(
                                  iconRightFlex: 1,
                                  iconLeftFlex: 1,
                                  textFlex: 2,
                                  contentFlex: 0,
                                  text: '${formatDate(initialTime.hour)}:${formatDate(initialTime.minute)}',
                                  fontSize: 16,
                                  iconLeft: Icons.access_time,
                                  iconRight: Icons.keyboard_arrow_down,
                                  iconLeftSize: 22,
                                  iconRightSize: 22,
                                  function: (){
                                    setState(() {
                                      isFromVisible = !isFromVisible;
                                    });
                                  },
                                  height: 40,
                                  width: 140,
                                  content: Container()
                              ),
                            ],
                          ),
                          const SizedBox(width: 20,),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Text('Hasta:', style: TextStyle(fontSize: 16, color: KGrey2),),
                                  SizedBox(width: 100,)
                                ],
                              ),
                              const SizedBox(height: 2,),
                              button(
                                  iconRightFlex: 1,
                                  iconLeftFlex: 1,
                                  textFlex: 2,
                                  contentFlex: 0,
                                  text: '${formatDate(initialTime.hour + 1)}:${formatDate(initialTime.minute)}',
                                  fontSize: 16,
                                  iconLeft: Icons.access_time,
                                  iconRight: Icons.keyboard_arrow_down,
                                  iconLeftSize: 22,
                                  iconRightSize: 22,
                                  function: (){
                                    setState(() {
                                      isToVisible = !isToVisible;
                                      //showSpinnerTimePicker(context);
                                    });
                                  },
                                  height: 40,
                                  width: 140,
                                  content: Container()
                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 380,),
                      buttons()
                    ],
                  ),

                  isToVisible? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 150,),
                            Container(
                              width: 290,
                              height: 400,
                              decoration: BoxDecoration(
                                color: KWhite,
                                border: Border.all(color: KSecondary,),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(color: KGray, blurRadius: 12, offset: Offset(0, 4))],
                              ),
                              child: Stack(
                                children: [
                                  timeCapsule(100, 48),
                                  Positioned(
                                    top: 100,
                                    left: 50,
                                    child: TimePickerSpinner(
                                      highlightedTextStyle: TextStyle(fontSize: 40, color: KBlack),
                                      normalTextStyle: TextStyle(fontSize: 38, color: KBlack.withOpacity(0.2)),
                                      itemHeight: 60,
                                      itemWidth: 50,
                                      spacing: 25,
                                      isForce2Digits: true,
                                      time: initialDate.add(const Duration(hours: 1)),
                                      is24HourMode: true,
                                    ),
                                  ),
                                  Positioned(
                                      top: 350,
                                      left: 10,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.keyboard_alt_outlined,size: 38,),
                                          const SizedBox(width: 95,),
                                          Container(
                                            height: 30,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              color: KWhite,
                                              border: Border.all(color: KBlack),
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(child: Text('Cancelar')),
                                          ),
                                          const SizedBox(width: 10,),
                                          Container(
                                            height: 30,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: KWhite,
                                              border: Border.all(color: KBlack),
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(child: Text('Aceptar')),
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) : Container(),

                  isFromVisible? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 150,),
                            Container(
                              width: 290,
                              height: 400,
                              decoration: BoxDecoration(
                                color: KWhite,
                                border: Border.all(color: KSecondary),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(color: KGray, blurRadius: 12, offset: Offset(0, 4))],
                              ),
                              child: Stack(
                                children: [
                                  timeCapsule(100, 48),
                                  Positioned(
                                    top: 100,
                                    left: 50,
                                    child: TimePickerSpinner(
                                      highlightedTextStyle: TextStyle(fontSize: 40, color: KBlack),
                                      normalTextStyle: TextStyle(fontSize: 40, color: KBlack.withOpacity(0.2)),
                                      itemHeight: 60,
                                      itemWidth: 50,
                                      spacing: 25,
                                      isForce2Digits: true,
                                      time: initialDate,
                                      is24HourMode: true,
                                    ),
                                  ),
                                  Positioned(
                                      top: 350,
                                      left: 10,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.keyboard_alt_outlined,size: 38,),
                                          const SizedBox(width: 95,),
                                          Container(
                                            height: 30,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              color: KWhite,
                                              border: Border.all(color: KBlack),
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: const Center(child: Text('Cancelar')),
                                          ),
                                          const SizedBox(width: 10,),
                                          Container(
                                            height: 30,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: KWhite,
                                              border: Border.all(color: KBlack),
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(child: Text('Aceptar')),
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                    ],
                  ) : Container(),

                  isEventDayVisible? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 80,),
                          Container(
                            width: 300,
                            height: 400,
                            decoration: BoxDecoration(
                                color: KWhite,
                                border: Border.all(color: KSecondary),
                                boxShadow: const [
                                  BoxShadow(
                                      color: KGray,
                                      blurRadius: 12,
                                      offset: Offset(0, 4))],
                                borderRadius: const BorderRadius.all(Radius.circular(5))
                            ),
                            child: CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  selectedDayHighlightColor: KSecondary
                                ),
                                value: [initialDate],
                            )
                          ),
                        ],
                      ),
                    ],
                  ) : Container(),

                  /*Positioned(
                    child: Container(),
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownMenuNormal(){
    DateTime initialDate = DateTime.now();
    return DropdownButton(
      menuMaxHeight: 800,
      itemHeight: 100,
      value: 1,
      items: [
        DropdownMenuItem(value: 1, child: Text('1')),
        //DropdownMenuItem(value: 2, child: Text('2')),
        DropdownMenuItem(
          value: 2,
          child: Container(
            height: 800,
            width: 400,
            color: KWhite,
            child: CalendarDatePicker(
                initialDate: initialDate,
                firstDate: initialDate,
                lastDate: initialDate,
                onDateChanged: (date){}
            ),
          ),
        ),
      ],
      onChanged: (item) {

      },
    );
  }

  /*Widget dropdownMenu(String title, String text){
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

    return Column(
      children: [
        Text(title),
        Dropdown(
            button: button('a', Icons.add, Icons.abc_outlined, (){}),
            content: CalendarDatePicker(
                initialDate: initialDate,
                firstDate: initialDate,
                lastDate: initialDate,
                onDateChanged: (date){}
            ),
          widthOpen: 200,
          heightOpen: 500,
        ),
      ],
    );
  }*/
  
  Widget dropdownExt(){
    DateTime initialDate = DateTime.now();
    return DropdownButton2(
        customButton: Center(
          child: Container(
              decoration: BoxDecoration(color: KWhite),
              child: Row(children: [Text('a'), Icon(Icons.add, color: KBlack,)],)),
        ),
        hint: Text('a'),
        style: TextStyle(color: KBlack),
        dropdownStyleData: DropdownStyleData(maxHeight: 400, width: 400),
        menuItemStyleData: MenuItemStyleData(height: 400),
        items:[
          //DropdownMenuItem(value: 1, child: Text('1')),
          //DropdownMenuItem(value: 2, child: Text('2')),
          DropdownMenuItem(
            value: 1,
            child: Container(
              height: 800,
              width: 400,
              color: KWhite,
              child: CalendarDatePicker(
                  initialDate: initialDate,
                  firstDate: initialDate,
                  lastDate: initialDate,
                  onDateChanged: (date){}
              ),
            ),
          ),
        ],
      onChanged: (item) {

      },
    );
  }

  Widget trueDropdown(){
    DateTime initialDate = DateTime.now();
    return Container(
      height: 400,
      width: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 50,
              child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      isWidgetVisible = !isWidgetVisible;
                    });
                  },
                  child: Text('a', style: TextStyle(color: KBlack),)
              )
          ),
          isWidgetVisible? Positioned(
            top: 100,
            child: Container(
              width: 400,
              height: 400,
              color: KBlack,
              child: Center(
                child: Text('Widget Superpuesto'),
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }

  Widget eventDayFromAndTo(double positioned, bool isWidgetVisible, Color? color, context){
    return Positioned(
        top: positioned,
        child: ElevatedButton(
            onPressed: (){
              setState(() {
                isWidgetVisible = !isWidgetVisible;
              });
            },
            child: Text('a', style: TextStyle(color: color),)
        )
    );
  }

  Widget timeCapsule(double? top, double? left){
    Decoration? decorationOfCapsules = BoxDecoration(
        color: KWhite,
        border: Border.all(color: KBlack),
        borderRadius: BorderRadius.circular(5)
    );
    double? heightCapsulesExt = 50;
    double? heightCapsulesMidl = 80;
    double? widthCapsules = 60;
    return Positioned(
      top: top,
      left: left,
      child: Row(
        children: [
          Column(
            children: [
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsules,),
              Container(height: heightCapsulesMidl, width: widthCapsules, decoration: decorationOfCapsules,),
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsules,),
            ],
          ),
          Column(
            children: [
              Container(height: 10, width: 10, decoration: BoxDecoration(color: KWhite, border: Border.all(color: KBlack), borderRadius: const BorderRadius.all(Radius.circular(20))),),
              Container(height: 10, width: 15, color: KTransparent,),
              Container(height: 10, width: 10, decoration: BoxDecoration(color: KWhite, border: Border.all(color: KBlack), borderRadius: const BorderRadius.all(Radius.circular(20))),),
            ],
          ),
          Column(
            children: [
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsules,),
              Container(height: heightCapsulesMidl, width: widthCapsules, decoration: decorationOfCapsules,),
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsules,),
            ],
          ),

        ],
      ),
    );
  }

  Widget button({
    required String text,
    required int iconLeftFlex,
    double? iconLeftSize,
    double? iconRightSize,
    required int iconRightFlex,
    required int textFlex,
    required int contentFlex,
    IconData? iconLeft,
    iconRight, function,
    double? height,
    double? width,
    content,
    double? fontSize
  }){
    return InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(color: KPrimary_L1, borderRadius: BorderRadius.all(Radius.circular(5))),
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Expanded(flex: iconLeftFlex, child: Icon(iconLeft, color: KGrey5, size: iconLeftSize,)),
              Expanded(flex: textFlex, child: Text(text, style: TextStyle(fontSize: fontSize, color: KGrey5),)),
              Expanded(flex: contentFlex, child: content),
              Expanded(flex: iconRightFlex, child: Icon(iconRight, color: KGrey5, size: iconRightSize,)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonMultifunction(
          text: Text('Cancelar', style: TextStyle(fontSize: 20, color: KDefault_Text),),
          onTap: (){
            _con.onPressedCancel(context);
          },
          withIcon: true,
          iconRight: true,
          width: 140,
          backgroundColor: KTransparent,
          icon: Icon(Icons.clear, color: KCancel, size: 30,),
          withBorder: true,
        ),
        ButtonMultifunction(
          text: Text('Siguiente', style: TextStyle(fontSize: 20),),
          onTap: (){
            _con.onPressedFollowing(context);
          },
          withIcon: true,
          iconRight: true,
          width: 140,
          backgroundColor: KTransparent,
          icon: const Icon(Icons.check, color: KAccept, size: 30,),
          withBorder: true,
        ),
      ],
    );
  }
}
