import 'package:flutter/material.dart';
import 'package:flutter_kalender/functions/headline.dart';
import 'package:flutter_kalender/functions/calender_table.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkmode
          ? Colors.black
          : Color.fromARGB(143, 149, 141, 179),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 59, 78),
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

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       widget.selectedDate = DateTime.now();
        //     });
        //   },
        // ),
      ),
    );
  }
}
