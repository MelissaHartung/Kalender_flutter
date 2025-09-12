import 'package:flutter/material.dart';

int berechneTagdesJahres(DateTime datum) {
  DateTime startJahr = DateTime(datum.year, 1, 1);
  return datum.difference(startJahr).inDays + 1;
}

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