import 'package:flutter/material.dart';
import 'Kalender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'information_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de_DE', null);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime _selectedDate = DateTime.now();
  String infoText = "";

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

  void _setDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  void _updateText(String newText) {
    setState(() {
      infoText = newText;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (Kalender(
        selectedDate: _selectedDate,
        previousMonth: _previousMonth,
        nextMonth: _nextMonth,
        setDate: _setDate,
        updateText: _updateText,
      )),
      routes: {
        '/information_page': (context) => InformationPage(
          selectedDate: _selectedDate,
          infoText: infoText,
          previousMonth: _previousMonth,
          nextMonth: _nextMonth,
        ),
      },
    );
  }
}
