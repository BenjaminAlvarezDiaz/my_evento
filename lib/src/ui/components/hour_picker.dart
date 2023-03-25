import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  const HourPicker({Key? key}) : super(key: key);

  @override
  State<HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 200,
      width: 400,
    );
  }
}
