import 'package:flutter/material.dart';
import 'package:flutter_kalender/functions/add_todo_page.dart';
import 'Kalender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'information_page.dart';
import 'package:flutter_kalender/functions/to_do.dart';

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

  void _nextWeek() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 7));
    });
  }

  void _previousWeek() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
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
        previousMonth: _previousWeek,
        nextMonth: _nextWeek,
        setDate: _setDate,
        updateText: _updateText,
      )),
      routes: {
        '/add_todo_page': (context) => AddTodoPage(date: _selectedDate),
        '/information_page': (context) => InformationPage(
          selectedDate: _selectedDate,
          infoText: infoText,
          previousMonth: _previousWeek,
          nextMonth: _nextWeek,
        ),
      },
    );
  }
}
