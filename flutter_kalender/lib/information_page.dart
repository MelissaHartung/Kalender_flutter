import 'package:flutter/material.dart';
import 'package:flutter_kalender/Kalender.dart';
import 'package:flutter_kalender/functions/information_text.dart';
// import 'package:intl/intl.dart';
import 'functions/headline.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      // appBar: AppBar(title: const Text('Information')),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),

            Headline(
              selectedDate: _selectedDate,
              onPreviousMonth: _previousMonth,
              onNextMonth: _nextMonth,
            ),
            InformationText(selectedDate: _selectedDate),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Kalender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
