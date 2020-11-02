import 'package:flutter/material.dart';

class Task with ChangeNotifier {
  final String title;
  final String description;
  final String duration;
  final DateTime startTime;
  final DateTime endTime;
  final String date;
  final bool status;

  Task({
    @required this.title,
    this.description,
    @required this.duration,
    @required this.startTime,
    @required this.endTime,
    @required this.date,
    @required this.status,
  });
}
