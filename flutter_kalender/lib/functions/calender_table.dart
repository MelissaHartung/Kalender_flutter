import 'package:flutter/material.dart';

class CalenderTable extends StatelessWidget {
  final DateTime selectedDate;

  const CalenderTable({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final DateTime firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      1,
    );
    final DateTime lastDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );
    int startWeekday = firstDayOfMonth.weekday;
    int daysInMonth = lastDayOfMonth.day;
    final List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    List<Widget> dayCells = [];

    for (int i = 1; i < startWeekday; i++) {
      dayCells.add(Container());
    }
    for (int i = 1; i <= daysInMonth; i++) {
      dayCells.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('$i'),
        ),
      );
    }
    int rowCount = (dayCells.length / 7).ceil();
    final List<TableRow> rows = [];

    rows.add(
      TableRow(
        children: weekdays.map((day) => Center(child: Text(day))).toList(),
      ),
    );
    for (int i = 0; i < rowCount; i++) {
      int startindex = i * 7;
      int endIndex = startindex + 7;
      if (startindex >= dayCells.length) {
        break;
      }

      List<Widget> weekCells = dayCells.sublist(
        startindex,
        endIndex > dayCells.length ? dayCells.length : endIndex,
      );
      while (weekCells.length < 7) {
        weekCells.add(Container());
      }
      rows.add(TableRow(children: weekCells));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        children: rows,
      ),
    );
  }
}
