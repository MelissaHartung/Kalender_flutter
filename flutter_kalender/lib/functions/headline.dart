import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Headline extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onPreviousMonth;
  final VoidCallback? onNextMonth;

  const Headline({
    super.key,
    required this.selectedDate,
    this.onPreviousMonth,
    this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    final String angezeigterText = DateFormat.yMMMMd(
      'de_DE',
    ).format(selectedDate);
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onPreviousMonth != null)
              IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.white, size: 40),
                onPressed: onPreviousMonth,
              ),
            Text(
              angezeigterText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (onNextMonth != null)
              IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.white, size: 40),
                onPressed: onNextMonth,
              ),
          ],
        ),
      ],
    );
  }
}
