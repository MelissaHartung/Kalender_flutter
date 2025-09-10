import 'package:flutter/material.dart';
import 'package:flutter_kalender/functions/headline.dart';
import 'package:flutter_kalender/functions/calender_table.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 127, 167, 128),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Headline(
              selectedDate: _selectedDate,
              onPreviousMonth: _previousMonth,
              onNextMonth: _nextMonth,
            ),
            CalenderTable(selectedDate: _selectedDate),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
        //       _selectedDate = DateTime.now();
        //     });
        //   },
        // ),
      ),
    );
  }
}
