import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class Feiertag {
  final String date;
  final String name;
  Feiertag({required this.date, required this.name});
}

class Feiertage {
  Feiertage();

  static final List<Feiertag> fixedFeiertage = [
    Feiertag(date: "01.01.", name: "Neujahr"),
    Feiertag(date: "06.01.", name: "Heilige Drei Könige"),
    Feiertag(date: "01.05.", name: "Tag der Arbeit"),
    Feiertag(date: "03.10.", name: "Tag der Deutschen Einheit"),
    Feiertag(date: "24.12.", name: "Heiligabend"),
    Feiertag(date: "25.12.", name: "1. Weihnachtstag"),
    Feiertag(date: "26.12.", name: "2. Weihnachtstag"),
  ];

  static List<Feiertag> calcFeiertageForYear(int year) {
    final formatter = DateFormat('dd.MM.');

    final feiertage = [...fixedFeiertage];

    final ostern = getOstersonntag(year);

    final gruenendonnerstag = ostern.subtract(Duration(days: 3));
    final karfreitag = ostern.subtract(Duration(days: 2));
    final ostermontag = ostern.add(Duration(days: 1));
    final christiHimmelfahrt = ostern.add(Duration(days: 39));
    final pfingstsonntag = ostern.add(Duration(days: 49));
    final pfingstmontag = ostern.add(Duration(days: 50));
    final fronleichnam = ostern.add(Duration(days: 60));

    feiertage.addAll([
      Feiertag(date: formatter.format(ostern), name: "Ostersonntag"),
      Feiertag(
        date: formatter.format(gruenendonnerstag),
        name: "Gründonnerstag",
      ),
      Feiertag(date: formatter.format(karfreitag), name: "Karfreitag"),
      Feiertag(date: formatter.format(ostermontag), name: "Ostermontag"),
      Feiertag(
        date: formatter.format(christiHimmelfahrt),
        name: "Christi Himmelfahrt",
      ),
      Feiertag(date: formatter.format(pfingstsonntag), name: "Pfingstsonntag"),
      Feiertag(date: formatter.format(pfingstmontag), name: "Pfingstmontag"),
      Feiertag(date: formatter.format(fronleichnam), name: "Fronleichnam"),
    ]);
    return feiertage;
  }

  static String getHoliday(DateTime date) {
    Feiertag? holiday = calcFeiertageForYear(date.year).firstWhereOrNull(
      (feiertag) =>
          feiertag.date ==
          "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.",
    );

    if (holiday != null) return holiday.name;
    return "Kein Feiertag";
  }
}

// ✅ Funktion zur Berechnung des Ostersonntags
DateTime getOstersonntag(int jahr) {
  final a = jahr % 19;
  final b = jahr ~/ 100;
  final c = jahr % 100;
  final d = b ~/ 4;
  final e = b % 4;
  final f = (b + 8) ~/ 25;
  final g = (b - f + 1) ~/ 3;
  final h = (19 * a + b - d - g + 15) % 30;
  final i = c ~/ 4;
  final k = c % 4;
  final l = (32 + 2 * e + 2 * i - h - k) % 7;
  final m = (a + 11 * h + 22 * l) ~/ 451;
  final monat = (h + l - 7 * m + 114) ~/ 31;
  final tag = ((h + l - 7 * m + 114) % 31) + 1;
  return DateTime(jahr, monat, tag);
}
