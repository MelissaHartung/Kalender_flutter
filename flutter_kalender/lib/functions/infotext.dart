import 'package:flutter/material.dart';

int berechneTagdesJahres(DateTime datum) {
  DateTime startJahr = DateTime(datum.year, 1, 1);
  return datum.difference(startJahr).inDays + 1;
}

DateTime now = DateTime.now();
int dayOfWeek = now.day;
String wochentagName = wochentage[now.weekday - 1];
String monatName = monate[now.month - 1];

String getWeekOfday(DateTime datum) {
  if (dayOfWeek <= 1) {
    return "erste";
  } else if (dayOfWeek <= 14) {
    return "zweite";
  } else if (dayOfWeek <= 21) {
    return "dritte";
  } else if (dayOfWeek <= 28) {
    return "vierte";
  } else {
    return "fünfte";
  }
}

List<String> wochentage = [
  'Montag',
  'Dienstag',
  'Mittwoch',
  'Donnerstag',
  'Freitag',
  'Samstag',
  'Sonntag',
];

List<String> monate = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember',
];

class Infotext extends StatefulWidget {
  const Infotext({super.key});

  @override
  State<Infotext> createState() => _InfotextState();
}

class _InfotextState extends State<Infotext> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
