import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headline extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const Headline({
    super.key,
    required this.selectedDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat.yMMMM('de_DE').format(selectedDate);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.chevron_left), onPressed: onPreviousMonth),
        Text(
          formattedMonth,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IconButton(icon: Icon(Icons.chevron_right), onPressed: onNextMonth),
      ],
    );
  }
}
