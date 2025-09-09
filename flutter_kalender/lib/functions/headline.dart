import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headline extends StatefulWidget {
  const Headline({super.key});

  @override
  State<Headline> createState() => _HeadlineState();
}

class _HeadlineState extends State<Headline> {
  DateTime _selectedDate = DateTime.now();

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
    });
  }

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat.yMMMM('de_DE').format(_selectedDate);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.chevron_left), onPressed: _previousMonth),
        Text(
          formattedMonth,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IconButton(icon: Icon(Icons.chevron_right), onPressed: _nextMonth),
      ],
    );
  }
}
