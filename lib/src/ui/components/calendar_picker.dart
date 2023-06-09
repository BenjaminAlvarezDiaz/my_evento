import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({Key? key}) : super(key: key);

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {

  late List<CalendarDate> _daysInMonth;
  //late List<CalendarDate> _lastDaysInMonth;
  late int _daysPassed;
  DateTime timeNow = DateTime.now();
  //int otherIndex = 0;
  double? widthCalendar = 500;
  double? heightCalendar = 500;
  List<String> _monthsOfTheYear = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];


  List<CalendarDate> _getDaysInMonth(int month, int year) {
    List<CalendarDate> daysInMonthList = [];
    int daysInPreviousMonth = DateTime(year, month, 0).day; // Días del mes anterior
    int daysInMonth = DateTime(year, month + 1, 0).day; // Días del mes actual

    // Obtener los días del mes anterior para completar la primera semana
    int weekdayOfFirstDayOfMonth = DateTime(year, month, 1).weekday; // Obtener el día de la semana del primer día del mes
    int daysInPreviousMonthToShow = weekdayOfFirstDayOfMonth - 1; // Días del mes anterior que se mostrarán en la primera semana
    for (int i = daysInPreviousMonth - daysInPreviousMonthToShow + 1; i <= daysInPreviousMonth; i++) {
      daysInMonthList.add(CalendarDate(i, month - 1, year));
    }

    // Obtener los días del mes actual
    for (int i = 1; i <= daysInMonth; i++) {
      daysInMonthList.add(CalendarDate(i, month, year));
    }

    // Obtener los días del mes siguiente para completar la última semana
    int weekdayOfLastDayOfMonth = DateTime(year, month, daysInMonth).weekday; // Obtener el día de la semana del último día del mes
    int daysInNextMonthToShow = 7 - weekdayOfLastDayOfMonth; // Días del mes siguiente que se mostrarán en la última semana
    for (int i = 1; i <= daysInNextMonthToShow; i++) {
      daysInMonthList.add(CalendarDate(i, month + 1, year));
    }

    return daysInMonthList;
  }

  /*List<CalendarDate> _getLastDaysOfMonth(DateTime currentDate){
    DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    List<CalendarDate> remainingDaysOfMonth = [];
    for (int i = currentDate.day; i <= lastDayOfMonth.day; i++) {
      remainingDaysOfMonth.add(CalendarDate(currentDate.year, currentDate.month, i));
    }
    return remainingDaysOfMonth;
  }*/

  int _getDaysPassed(int currentDate){
    //DateTime firstDayOfLastMonth = DateTime(currentDate.year, currentDate.month - 1, 1);
    //int daysInLastMonth = DateTime(firstDayOfLastMonth.year, firstDayOfLastMonth.month + 1, 0).day;
    //int daysInCurrentMonth = DateTime(currentDate.year, currentDate.month, 0).day;
    int daysPassedInCurrentMonth = currentDate + 1;
    //int daysPassedInLastMonth = daysInLastMonth - (daysInCurrentMonth - daysPassedInCurrentMonth);
    //int daysPassed = currentDate.difference(firstDayOfLastMonth).inDays - daysInLastMonth;
    return daysPassedInCurrentMonth;
  }

  @override
  void initState() {
    super.initState();
    _daysInMonth = _getDaysInMonth(timeNow.month, timeNow.year);
    //_lastDaysInMonth = _getLastDaysOfMonth(DateTime.now());
    _daysPassed = _getDaysPassed(timeNow.day);
  }


  @override
  Widget build(BuildContext context) {
    int _currentMonth = DateTime.now().month;
    int _currentDay = DateTime.now().day;
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.white,
        width: widthCalendar,
        height: heightCalendar,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: Column(
            children: [
              monthBuilder(widthCalendar, _monthsOfTheYear[_currentMonth - 1]),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: _daysInMonth.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,),
                  itemBuilder: (BuildContext context, int index) {
                    CalendarDate date = _daysInMonth[index];
                    bool isCurrentMonth = date.month == _currentMonth;
                    bool isCurrentDay = date.day == _currentDay;
                    Color textColor;
                    if(index < _daysPassed || (_currentMonth == 1 && index < _daysPassed + 4) || (_currentMonth == 12 && index < _daysPassed + 2)){
                      textColor = Colors.grey;
                    }else{
                      textColor = isCurrentMonth ? Colors.black : Colors.grey;
                    }
                    /*CalendarDate lastDays;
                    if(_daysInMonth[index].day >= _currentDay){
                      otherIndex++;
                      if(otherIndex < _lastDaysInMonth.length){
                        lastDays = _lastDaysInMonth[otherIndex];
                      }else{
                        lastDays = date;
                      }
                    }else{
                      lastDays = date;
                    }*/
                    //bool isLastDaysInMonth = date.day == lastDays.day;
                    return dayBuilder(date, textColor, isCurrentDay, isCurrentMonth);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dayBuilder(CalendarDate date, Color textColor, bool isCurrentDay, bool isCurrentMonth){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: isCurrentMonth ? isCurrentDay ? const Color(0xff7F0432) : textColor : textColor),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: TextStyle(
              color: isCurrentMonth ? isCurrentDay ? const Color(0xff7F0432) : textColor : textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${date.getWeekdayName()}',
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget monthBuilder(double? widthCalendar, String month){
    double? height = 50;
    double? sizeIcon = 20;
    double? fontSize = 20;
    Color? colorIcon = const Color(0xff7F0432);
    return Container(
      color: Colors.white,
      height: height,
      width: widthCalendar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, size: sizeIcon,),
            color: colorIcon,
            onPressed: (){

            },
          ),
          Container(
            color: Colors.white,
            width: widthCalendar! / 1.5,
            height: height,
            child: Center(child: Text(month, style: TextStyle(fontSize: fontSize),)),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined, size: sizeIcon,),
            color: colorIcon,
            onPressed: () {
              setState(() {
                timeNow.add(Duration(days: 31));
              });
            },
          )
        ],
      ),
    );
  }
}
class CalendarDate {
  int day;
  int month;
  int year;

  CalendarDate(this.day, this.month, this.year);

  String getWeekdayName() {
    DateTime date = DateTime(year, month, day);
    return DateFormat.E().format(date);
  }

}