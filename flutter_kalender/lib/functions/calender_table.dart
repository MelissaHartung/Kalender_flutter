import 'package:flutter/material.dart';
import 'package:flutter_kalender/functions/holidays.dart';

class CalenderTable extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) setDate;
  final Function(String) updateText;

  const CalenderTable({
    super.key,
    required this.date,
    required this.setDate,
    required this.updateText,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    List<Widget> weekCells = [];

    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      final heute = DateTime.now();
      final istHeute =
          day.day == heute.day &&
          day.month == heute.month &&
          day.year == heute.year;
      final istAusgewaehlt =
          day.day == date.day &&
          day.month == date.month &&
          day.year == date.year;

      weekCells.add(
        GestureDetector(
          onTap: () {
            setDate(day);
            updateText(Feiertage.getHoliday(day));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: istAusgewaehlt
                    ? Colors.grey[800] // Der ausgewählte Tag
                    : istHeute
                    ? const Color.fromARGB(255, 81, 168, 154)
                    : const Color.fromARGB(255, 0, 0, 0), // Alle anderen Tage
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${day.day}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      );
    }
    final List<TableRow> rows = [];

    rows.add(
      TableRow(
        children: weekdays
            .map(
              (day) => Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
    rows.add(TableRow(children: weekCells));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(children: rows),
    );
  }
}
