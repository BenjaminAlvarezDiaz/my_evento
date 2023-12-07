import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/screen_controllers/choose_day_and_time_screen_controller.dart';
import 'package:my_evento/values/k_images.dart';
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
  bool isEventDayVisible = false;
  bool isFromVisible = false;
  bool isToVisible = false;
  //bool changesInUp = true;
  bool allDay = false;
  bool isKeyBoard = true;
  ScreenArgs? args;
  DateTime timeEventDay = DateTime.now();
  DateTime onTimeChangedFrom = DateTime.now();
  DateTime onTimeChangedTo = DateTime.now();

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

  bool validateUntil(){
    DateTime currentDay = DateTime.now();
    if(allDay && (timeEventDay.day >= currentDay.day)){
      return true;
    }

    if(timeEventDay.day > currentDay.day){
      if((onTimeChangedTo.hour > onTimeChangedFrom.hour) ||
          (onTimeChangedTo.minute > onTimeChangedFrom.minute)){
        return true;
      }else{
        return false;
      }
    }else if(currentDay.day == timeEventDay.day){
      if((onTimeChangedFrom.hour >= currentDay.hour) && (onTimeChangedFrom.minute >= currentDay.minute)){
        print(onTimeChangedFrom.hour);
        print(onTimeChangedFrom.minute);
        if((onTimeChangedTo.hour >= onTimeChangedFrom.hour) &&
            (onTimeChangedTo.minute > onTimeChangedFrom.minute)){
          print('aaaaa');
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }
    }else{
      return false;
    }
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
                  //eventDayFromAndTo(250, isToVisible, KSecondary, context),
                  //eventDayFromAndTo(150, isFromVisible, KBlack, context),
                  //eventDayFromAndTo(50, isEventDayVisible, KRed, context),
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5,),
                          Text('Elija día del evento:', style: TextStyle(fontSize: 20, color: KGrey2),),
                          SizedBox(width: 140,)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      eventDayFromAndTo(
                          textFlex: 6,
                          contentFlex: 3,
                          text:' ${formatDate(timeEventDay.day)}'
                               '/${formatDate(timeEventDay.month)}'
                               '/${formatDate(timeEventDay.year)}',
                          height: 40,
                          width: 305,
                          onTap: (){
                            setState(() {
                              isEventDayVisible = !isEventDayVisible;
                            });
                          },
                          iconLeft: Icons.calendar_today,
                          iconRight: isEventDayVisible? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
                              eventDayFromAndTo(
                                  textFlex: 2,
                                  contentFlex: 0,
                                  text: '${formatHour(onTimeChangedFrom.hour)}:'
                                      '${formatDate(onTimeChangedFrom.minute)}',
                                  iconsSize: 22,
                                  height: 40,
                                  width: 140,
                                  onTap: (){
                                    setState(() {
                                      isFromVisible = !isFromVisible;
                                    });
                                  },
                                  iconLeft: Icons.access_time,
                                  iconRight: isFromVisible? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
                              eventDayFromAndTo(
                                  textFlex: 2,
                                  contentFlex: 0,
                                  text: '${formatHour(onTimeChangedTo.hour)}:'
                                      '${formatDate(onTimeChangedTo.minute)}',
                                  iconsSize: 22,
                                  height: 40,
                                  width: 140,
                                  onTap: (){
                                    setState(() {
                                      isToVisible = !isToVisible;
                                    });
                                  },
                                  iconLeft: Icons.access_time,
                                  iconRight: isToVisible? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                allDay = !allDay;
                              });
                            },
                            child: Row(
                              children: [
                                allDay? Icon(Icons.radio_button_checked_outlined, color: KSecondary,) :
                                Icon(Icons.radio_button_off_outlined, color: KSecondary_L1,),
                                SizedBox(width: 5,),
                                Text('Todo el dia', style: TextStyle(fontSize: 16, color: KGrey2),),
                              ],
                            ),
                          ),
                          SizedBox(width: 200,)
                        ],
                      ),
                      SizedBox(height: 350,),
                      buttonsCancelAndContinue()
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
                                      time: onTimeChangedTo,
                                      is24HourMode: true,
                                      onTimeChange: (onTimeChanged){
                                        onTimeChangedTo = onTimeChanged;
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      top: 350,
                                      left: 10,
                                      child: buttonsOfFromAndTo(
                                          onTapCancel: (){
                                            setState(() {
                                              isToVisible = !isToVisible;
                                              onTimeChangedTo = DateTime.now();
                                            });
                                          },
                                          onTapAccept: (){
                                            setState(() {
                                              isToVisible = !isToVisible;
                                            });
                                          }
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
                                      time: onTimeChangedFrom,
                                      is24HourMode: true,
                                      onTimeChange: (onTimeChanged){
                                        onTimeChangedFrom = onTimeChanged;
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      top: 350,
                                      left: 10,
                                      child: buttonsOfFromAndTo(
                                          onTapCancel: (){
                                            setState(() {
                                              isFromVisible = !isFromVisible;
                                              onTimeChangedFrom = DateTime.now();
                                            });
                                          },
                                          onTapAccept: (){
                                            setState(() {
                                              isFromVisible = !isFromVisible;
                                            });
                                          }
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
                            child: Column(
                              children: [
                                CalendarDatePicker2(
                                  config: CalendarDatePicker2Config(
                                      selectedDayHighlightColor: KSecondary,
                                      calendarType: CalendarDatePicker2Type.single,
                                  ),
                                  value: [timeEventDay],
                                  onValueChanged: (onValueChanged){
                                    timeEventDay = onValueChanged.elementAt(0)!;
                                    //print(timeEventDay);
                                    setState(() {
                                      isEventDayVisible = !isEventDayVisible;
                                    });
                                  },
                                ),
                                /*Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(children: [
                                    Expanded(flex: 3, child: SizedBox(width: 2,)),
                                    Expanded(flex: 2, child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          isEventDayVisible = !isEventDayVisible;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 65,
                                        decoration: BoxDecoration(
                                            color: KWhite,
                                            border: Border.all(color: KBlack),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: const Center(child: Text('Cancelar')),
                                      ),
                                    ),),
                                    SizedBox(width: 10,),
                                    Expanded(flex: 2, child: InkWell(
                                      onTap: (){
                                        isEventDayVisible = !isEventDayVisible;
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: KWhite,
                                            border: Border.all(color: KBlack),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Text('Aceptar')),
                                      ),
                                    ),)
                                  ],),
                                ),*/
                              ],
                            )
                          ),
                        ],
                      ),
                    ],
                  ) : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget eventDayFromAndTo({
    required String text,
    Function()? onTap,
    int textFlex = 4,
    int contentFlex = 3,
    double? iconsSize = 24.0,
    double? height,
    double? width,
    IconData? iconLeft,
    IconData? iconRight,
  }){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: KPrimary_L1, borderRadius: BorderRadius.all(Radius.circular(5))),
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Expanded(flex: 1, child: Icon(iconLeft, color: KGrey5, size: iconsSize,)),
              Expanded(flex: textFlex, child: Text(text, style: TextStyle(fontSize: 16, color: KGrey5),)),
              Expanded(flex: contentFlex, child: const SizedBox(width: 1,)),
              Expanded(flex: 1, child: Icon(iconRight, color: KGrey5, size: iconsSize,)),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeCapsule(double? top, double? left){
    Decoration? decorationOfCapsules = BoxDecoration(
        color: KWhite,
        border: Border.all(color: KSecondary_D1),
        borderRadius: BorderRadius.circular(5)
    );

    Decoration? decorationOfCapsulesUpAndDown = BoxDecoration(
        color: KWhite,
        border: Border.all(color: KSecondary_D1.withOpacity(0.5)),
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
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsulesUpAndDown,),
              Container(height: heightCapsulesMidl, width: widthCapsules, decoration: decorationOfCapsules,),
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsulesUpAndDown,),
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
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsulesUpAndDown,),
              Container(height: heightCapsulesMidl, width: widthCapsules, decoration: decorationOfCapsules,),
              Container(height: heightCapsulesExt, width: widthCapsules, decoration: decorationOfCapsulesUpAndDown,),
            ],
          ),

        ],
      ),
    );
  }

  Widget buttonsOfFromAndTo({
    Function()? onTapCancel,
    Function()? onTapAccept,
  }){
    IconData? iconLeft = Icons.keyboard_alt_outlined;
    return Row(
      children: [
        InkWell(
            onTap: (){
              setState(() {
                isKeyBoard = !isKeyBoard;
              });
            },
            child: Icon(isKeyBoard? Icons.keyboard_alt_outlined : Icons.swipe, size: 38,)
        ),
        const SizedBox(width: 95,),
        InkWell(
          onTap: onTapCancel,
          child: Container(
            height: 30,
            width: 65,
            decoration: BoxDecoration(
                color: KWhite,
                border: Border.all(color: KBlack),
                borderRadius: BorderRadius.circular(5)
            ),
            child: const Center(child: Text('Cancelar')),
          ),
        ),
        const SizedBox(width: 10,),
        InkWell(
          onTap: onTapAccept,
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                color: KWhite,
                border: Border.all(color: KBlack),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(child: Text('Aceptar')),
          ),
        ),
      ],
    );
  }

  Widget buttonsCancelAndContinue(){
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
          text: Text('Siguiente', style: TextStyle(fontSize: 20, color: validateUntil()? null : KGrey3),),
          onTap: (){
            validateUntil()? _con.onPressedFollowing(context) :
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('ERROR, es probable que la hora de \"Desde\" esté mal puesta.'),
            ));
          },
          withIcon: true,
          iconRight: true,
          width: 140,
          backgroundColor: KTransparent,
          icon: Icon(Icons.check, color: validateUntil()? KAccept : KGrey3, size: 30,),
          withBorder: true,
        ),
      ],
    );
  }

}

