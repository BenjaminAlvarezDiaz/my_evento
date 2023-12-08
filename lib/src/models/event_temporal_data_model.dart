import 'package:flutter/cupertino.dart';

class EventTemporalData{
  final DateTime dateTime;
  final DateTime startTime;
  final DateTime endTime;
  final TextEditingController title;
  final TextEditingController description;

  EventTemporalData({
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
  });

}