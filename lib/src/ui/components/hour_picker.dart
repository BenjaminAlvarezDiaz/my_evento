import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialTime;

  HourPicker({
    Key? key,
    this.height = 400,
    this.width = 200,
    this.onChanged,
    this.initialTime,
    this.fontSize = 100

  }) : super(key: key);

  @override
  State<HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child){
        return builder();
      },
    );

    if (time != null && time != _selectedTime) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        color: Colors.white,
        height: 200,
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildWheelPicker(
              'Hour',
              List.generate(24, (i) => i),
                  (index) {
                setState(() {
                  _hour = index;
                });
              },
              _hour,
            ),
            SizedBox(width: 20),
            _buildWheelPicker(
              'Minute',
              List.generate(60, (i) => i),
                  (index) {
                setState(() {
                  _minute = index;
                });
              },
              _minute,
            ),
          ],
        ),
      ),
    );
  }

  Widget builder(){
    return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            // change the border color
            primary: Colors.red,
            // change the text color
            onSurface: Colors.purple,
          ),
          // button colors
          buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
            ),
          ),
        ),
        child: Center(child: Container(height: 100, width: 100, color: Colors.white,))
    );
  }

  Widget _buildWheelPicker(
      String title, List<int> items, Function(int) onChanged, int initialValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: ListWheelScrollView(
            //controller: ScrollController(initialScrollOffset: initialValue as double),
            itemExtent: 40,
            children: items.map((item) {
              return Center(
                child: Text(
                  item.toString(),
                  style: TextStyle(fontSize: 24),
                ),
              );
            }).toList(),
            onSelectedItemChanged: onChanged,
            physics: FixedExtentScrollPhysics(),
            useMagnifier: true,
            magnification: 1.2,
            squeeze: 1.4,
            diameterRatio: 1.3,
            perspective: 0.003,
            offAxisFraction: 0,
            clipBehavior: Clip.none,
            overAndUnderCenterOpacity: 0.7,
            renderChildrenOutsideViewport: true,
          ),
        ),
      ],
    );
  }
}
