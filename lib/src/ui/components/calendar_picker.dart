import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

class CalendarPicker extends StatefulWidget {
  final Color currentDayColor;
  final Color disabledColorDay;
  final Color enabledColorDay;
  final bool daysWithBorder;
  final bool enabledAllDaysOfMonth;
  final bool nameDaysWithBorder;
  final BorderRadiusGeometry? borderRadiusGeometryOfDay;
  final BorderRadiusGeometry? borderRadiusGeometryOfNameDay;
  final FontWeight? fontWeightOfDay;
  final FontWeight? fontWeightOfNameDay;
  final FontWeight? fontWeightOfMonth;
  final double? widthCalendar;
  final double? heightCalendar;
  late int? onTapDaySelected;
  final Function(CalendarDate) onDaySelected;
  CalendarPicker({
    Key? key,
    this.currentDayColor = const Color(0xff7F0432),
    this.disabledColorDay = Colors.grey,
    this.enabledColorDay = Colors.black,
    this.daysWithBorder = true,
    this.enabledAllDaysOfMonth = true,
    this.nameDaysWithBorder = true,
    this.borderRadiusGeometryOfDay = const BorderRadius.all(Radius.circular(10)),
    this.borderRadiusGeometryOfNameDay = const BorderRadius.all(Radius.circular(10)),
    this.fontWeightOfDay = FontWeight.bold,
    this.fontWeightOfNameDay,
    this.fontWeightOfMonth = FontWeight.bold,
    this.widthCalendar = 500,
    this.heightCalendar = 500,
    this.onTapDaySelected,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {

  late List<CalendarDate> _daysInMonth;
  //late List<CalendarDate> _lastDaysInMonth;
  late int _daysPassed;
  DateTime timeNow = DateTime.now();
  late bool isDayActivated;
  List<CalendarDate> daysInTheCurrentMonth= [];
  int otherIndex = -1;
  //int otherIndex = 0;
  final List<String> _monthsOfTheYear = [
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
      daysInTheCurrentMonth.add(CalendarDate(i, month, year));
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
        width: widget.widthCalendar! < 500 ? 500 : widget.widthCalendar,
        height: widget.heightCalendar! < 500 ? 500 : widget.heightCalendar,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: Column(
            children: [
              monthBuilder(
                  widget.widthCalendar! < 500 ? 500 : widget.widthCalendar,
                  _monthsOfTheYear[_currentMonth - 1]
              ),
              weekBuilder(),
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

                    if(!widget.enabledAllDaysOfMonth && isCurrentMonth){
                      otherIndex++;
                      if(daysInTheCurrentMonth[otherIndex].day < _currentDay){
                        textColor = widget.disabledColorDay;
                        isDayActivated = false;
                      }else{
                        textColor = widget.enabledColorDay;
                        isDayActivated = true;
                      }
                    }else{
                      textColor = isCurrentMonth ? widget.enabledColorDay : widget.disabledColorDay;
                      isDayActivated = true;
                      otherIndex = -1;
                    }
                    return dayBuilder(date, textColor, isCurrentDay, isCurrentMonth, isDayActivated);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dayBuilder(CalendarDate date, Color textColor, bool isCurrentDay, bool isCurrentMonth, bool isDayActivated){
    return isDayActivated ? InkWell(
      onTap: (){
        selectedDay(date.day);
        widget.onDaySelected(date);
      },
      child: Container(
        decoration: BoxDecoration(
          border: widget.daysWithBorder ? Border.all(color: isCurrentMonth ? isCurrentDay ? widget.currentDayColor : textColor : textColor) : null,
          borderRadius: widget.borderRadiusGeometryOfDay,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                color: isCurrentMonth ? isCurrentDay ? widget.currentDayColor : textColor : textColor,
                fontWeight: widget.fontWeightOfDay,
              ),
            ),
            /*Text(
              '${date.getWeekdayName()}',
              style: TextStyle(
                color: textColor,
              ),
            ),*/
          ],
        ),
      ),
    ) :
    Container(
      decoration: BoxDecoration(
        border: widget.daysWithBorder ? Border.all(color: isCurrentMonth ? isCurrentDay ? widget.currentDayColor : textColor : textColor) : null,
        borderRadius: widget.borderRadiusGeometryOfDay,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: TextStyle(
              color: isCurrentMonth ? isCurrentDay ? widget.currentDayColor : textColor : textColor,
              fontWeight: widget.fontWeightOfDay,
            ),
          ),
          /*Text(
              '${date.getWeekdayName()}',
              style: TextStyle(
                color: textColor,
              ),
            ),*/
        ],
      ),
    );
  }

  void selectedDay(int daySelected){
    widget.onTapDaySelected = daySelected == null ? DateTime.now().day : daySelected;
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
          widget.enabledAllDaysOfMonth ?
          IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, size: sizeIcon,),
            color: colorIcon,
            onPressed: (){

            },
          ) : SizedBox(width: sizeIcon * 2.4,),
          Container(
            color: Colors.white,
            width: widthCalendar! / 1.5,
            height: height,
            child: Center(child: Text(month, style: TextStyle(fontSize: fontSize, fontWeight: widget.fontWeightOfMonth),)),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined, size: sizeIcon,),
            color: colorIcon,
            onPressed: () {
              setState(() {
                timeNow.add(const Duration(days: 31));
              });
            },
          )
        ],
      ),
    );
  }

  Widget weekBuilder(){
    return Row(
      children: [
        nameDayBuilder('Lu'),
        nameDayBuilder('Ma'),
        nameDayBuilder('Mi'),
        nameDayBuilder('Ju'),
        nameDayBuilder('Vi'),
        nameDayBuilder('Sa'),
        nameDayBuilder('Do'),
      ],
    );
  }

  Widget nameDayBuilder(String day){
    return Expanded(
        flex: 2,
        child: Container(
          decoration: BoxDecoration(
            border: widget.nameDaysWithBorder ? Border.all(
                color: widget.enabledColorDay) : null,
            borderRadius: widget.borderRadiusGeometryOfNameDay,
          ),
          child: Center(child: Text('${day}', style: TextStyle(fontWeight: widget.fontWeightOfNameDay),)),
        )
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