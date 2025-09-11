import 'package:flutter/material.dart';
import 'functions/headline.dart';

class InformationPage extends StatefulWidget {
  final DateTime selectedDate;
  final String infoText;
  final VoidCallback previousMonth;
  final VoidCallback nextMonth;

  const InformationPage({
    super.key,
    required this.selectedDate,
    required this.infoText,
    required this.previousMonth,
    required this.nextMonth,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: const Color.fromARGB(255, 25, 53, 26)),
      body: SafeArea(
        child: Column(
          children: [
            Headline(
              selectedDate: widget.selectedDate,
              onPreviousMonth: widget.previousMonth,
              onNextMonth: widget.nextMonth,
            ),
            Text(widget.infoText),
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
