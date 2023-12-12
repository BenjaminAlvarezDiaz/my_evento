import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class EventTemporalData{
  final DateTime dateTime;
  final DateTime startTime;
  final DateTime endTime;
  final TextEditingController title;
  final TextEditingController description;
  XFile image;

  EventTemporalData({
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
    required this.image,
  });



}