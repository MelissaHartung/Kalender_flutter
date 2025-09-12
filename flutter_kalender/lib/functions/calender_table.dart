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
    final DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    final DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    int startWeekday = firstDayOfMonth.weekday;
    int daysInMonth = lastDayOfMonth.day;
    final List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    List<Widget> dayCells = [];

    for (int i = 1; i < startWeekday; i++) {
      dayCells.add(Container());
    }
    for (int i = 1; i <= daysInMonth; i++) {
      dayCells.add(
        GestureDetector(
          onTap: () => {
            setDate(DateTime(date.year, date.month, i)),
            updateText(
              Feiertage.getHoliday(DateTime(date.year, date.month, i)),
            ),
            Navigator.pushNamed(context, '/information_page'),
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 193, 190, 207),
                border: Border.all(color: const Color.fromARGB(176, 125, 113, 168), width: 3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text('$i',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    
                  ), 
            ),
          ),
        ),
      ));
    }
    int rowCount = (dayCells.length / 7).ceil();
    final List<TableRow> rows = [];

    rows.add(
      TableRow(
        children: weekdays.map((day) => Center(child: Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),))).toList(),
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
        // border: TableBorder.all(color: const Color.fromARGB(255, 0, 0, 0),
        // width: 1, borderRadius: BorderRadius.all(Radius.circular(10))),
        children: rows,
      ),
    );
  }
}
