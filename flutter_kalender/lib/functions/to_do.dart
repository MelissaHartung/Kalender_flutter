import 'package:flutter/material.dart';

class ToDo {
  String title;
  bool isDone;
  DateTime? starttime;
  Duration? duration;

  ToDo({
    required this.title,
    this.isDone = false,
    this.starttime,
    this.duration,
  });

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'starttime': starttime?.toIso8601String(),
      'duration': duration?.inMinutes,
    };
  }
}
