import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  final double? height;
  final double? width;
  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialTime;

  HourPicker({
    Key? key,
    this.height = 400,
    this.width = 200,
    this.onChanged,
    this.initialTime

  }) : super(key: key);

  @override
  State<HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialTime?.hour ?? TimeOfDay.now().hour;
    _minute = widget.initialTime?.minute ?? TimeOfDay.now().minute;
  }

  void _handleHourChanged(int? value) {
    setState(() {
      _hour = value!;
    });
    widget.onChanged?.call(TimeOfDay(hour: _hour, minute: _minute));
  }

  void _handleMinuteChanged(int? value) {
    setState(() {
      _minute = value!;
    });
    widget.onChanged?.call(TimeOfDay(hour: _hour, minute: _minute));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 200,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            value: _hour,
            items: List.generate(24, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              );
            }),
            onChanged: _handleHourChanged,
          ),
          SizedBox(width: 8),
          Text(':'),
          SizedBox(width: 8),
          DropdownButton<int>(
            value: _minute,
            items: List.generate(60, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              );
            }),
            onChanged: _handleMinuteChanged,
          ),
        ],
      ),
    );
  }
}
