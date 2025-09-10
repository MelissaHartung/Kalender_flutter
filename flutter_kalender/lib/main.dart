import 'package:flutter/material.dart';
import 'Kalender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'information_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de_DE', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (Kalender()),
      routes: {'/information_page': (context) => InformationPage()},
    );
  }
}
