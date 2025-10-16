import 'package:flutter/material.dart';
import 'package:flutter_kalender/functions/add_todo_page.dart';
import 'package:flutter_kalender/functions/headline.dart';
import 'package:flutter_kalender/functions/calender_table.dart';
import 'package:flutter_kalender/functions/holidays.dart';
import 'package:flutter_kalender/functions/to_do.dart';
import 'package:intl/intl.dart';

class Kalender extends StatefulWidget {
  final DateTime selectedDate;
  final VoidCallback previousMonth;
  final VoidCallback nextMonth;
  final Function(DateTime) setDate;
  final Function(String) updateText;
  const Kalender({
    super.key,
    required this.selectedDate,
    required this.previousMonth,
    required this.nextMonth,
    required this.setDate,
    required this.updateText,
  });

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  var isDarkmode = false;
  String buildSubtitle(ToDo todo) {
    String text = '';
    if (todo.starttime != null) {
      // Formatiere die Zeit schön, z.B. '14:30 Uhr'
      text += DateFormat('HH:mm').format(todo.starttime!) + ' Uhr';
    }
    if (todo.duration != null) {
      // Füge die Dauer hinzu, z.B. ' (30 Min)'
      text += ' (${todo.duration!.inMinutes} Min)';
    }
    return text;
  }

  Map<DateTime, List<ToDo>> allTodos = {};
  @override
  Widget build(BuildContext context) {
    // Sortiere die 'todos'-Liste
    List<ToDo> todos = allTodos.values.expand((list) => list).toList();
    todos.sort((a, b) {
      // Fall 1: a hat keine Zeit, b aber schon -> b kommt zuerst
      if (a.starttime == null && b.starttime != null) {
        return 1; // 1 bedeutet "b kommt vor a"
      }
      // Fall 2: b hat keine Zeit, a aber schon -> a kommt zuerst
      if (a.starttime != null && b.starttime == null) {
        return -1; // -1 bedeutet "a kommt vor b"
      }
      // Fall 3: Beide haben eine Zeit -> Vergleiche sie direkt
      if (a.starttime != null && b.starttime != null) {
        return a.starttime!.compareTo(b.starttime!);
      }
      // Fall 4: Beide haben keine Zeit -> Ihre Reihenfolge ist egal
      return 0;
    });

    final String holidayName = Feiertage.getHoliday(widget.selectedDate);
    final bool isHoliday = holidayName != "Kein Feiertag";
    return Scaffold(
      backgroundColor: isDarkmode ? Colors.black : Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDarkmode = !isDarkmode;
              });
            },
            icon: isDarkmode
                ? Icon(Icons.light_mode_rounded)
                : Icon(Icons.dark_mode_rounded),
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Headline(
              selectedDate: widget.selectedDate,
              onPreviousMonth: widget.previousMonth,
              onNextMonth: widget.nextMonth,
            ),
            CalenderTable(
              date: widget.selectedDate,
              setDate: widget.setDate,
              updateText: widget.updateText,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    31,
                    30,
                    30,
                  ), // Farbe hierher verschoben
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double
                    .infinity, // Sorgt dafür, dass der Container die volle Breite einnimmt
                child: ListView.builder(
                  itemCount: todos.length + (isHoliday ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (isHoliday && index == 0) {
                      // Dies ist das Widget für den Feiertag
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        child: Card(
                          color: const Color.fromARGB(
                            255,
                            192,
                            80,
                            145,
                          ), // Eine hervorhebende Farbe
                          child: Padding(
                            padding: const EdgeInsets.all(
                              8.0,
                            ), // Etwas weniger Padding für "schmaler"
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.celebration, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  holidayName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    final todoIndex = isHoliday ? index - 1 : index;
                    final todo = todos[todoIndex];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              todo.starttime != null
                                  ? DateFormat('HH:mm').format(todo.starttime!)
                                  : '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // Hier kommt später die Zeitachsen-Grafik hin
                          SizedBox(width: 20),
                          Expanded(
                            child: Card(
                              color: Colors.grey[900],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  todo.title,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: 0,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/information_page');
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Kalender',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded),
            label: 'Info',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 81, 168, 154),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoPage(date: widget.selectedDate),
            ),
          ).then((newTodo) {
            if (newTodo != null && newTodo is ToDo) {
              setState(() {});
            }
          });
        },
      ),
    );
  }
}
