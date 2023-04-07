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
  late int _hour;
  late int _minute;
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
    return Container(
      color: Colors.red,
      height: 200,
      width: 400,
      child: Row(
        children: [
          Container(
            height: 200,
            child: Text('${_selectedTime.hour}', style: TextStyle(fontSize: widget.fontSize),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Text(':', style: TextStyle(fontSize: widget.fontSize),)),
              Container(height: 50, color: Colors.white,)
            ],
          ),
          Container(
            height: 200,
            child: Text('${_selectedTime.minute}', style: TextStyle(fontSize: widget.fontSize),),
          ),
        ],
      )
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
}
