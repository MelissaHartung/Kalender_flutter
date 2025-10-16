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
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 400,
                      child: CalendarDatePicker(
                        initialDate: selectedDate,
                        firstDate: DateTime(selectedDate.year - 5),
                        lastDate: DateTime(selectedDate.year + 5),
                        onDateChanged: (newDate) {
                          void Function(DateTime)? setDate;
                          if (setDate != null) {
                            setDate(newDate);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
                Text(
                  'Heute ist der $angezeigterText',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
              child: Text(
                angezeigterText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
