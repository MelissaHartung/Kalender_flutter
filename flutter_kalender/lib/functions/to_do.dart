import 'package:flutter/material.dart';

class ToDo {
  String title;
  bool isDone;
  TimeOfDay? starttime; 
  Duration? duration;

  ToDo({required this.title, this.isDone = false, this.starttime, this.duration});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'starttime': starttime != null ? {'hour': starttime!.hour, 'minute': starttime!.minute} : null,
      'duration': duration?.inMinutes, 
    };
  }
}