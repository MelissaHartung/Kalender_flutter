import 'package:flutter/material.dart';
import 'package:flutter_kalender/notizen.dart';
import 'functions/headline.dart';
import 'functions/history_dates.dart';
import 'functions/infotext.dart';
import 'package:intl/intl.dart';

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
  bool isDarkMode = false;
  bool isEditing = false;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String formatiertesDatum = DateFormat(
      'dd.MM.yyyy',
    ).format(widget.selectedDate);
    final int tagImJahr = berechneTagdesJahres(widget.selectedDate);
    final String wochentag = getWeekOfday(widget.selectedDate);
    final String wochentagName = wochentage[widget.selectedDate.weekday - 1];
    final String monatName = monate[widget.selectedDate.month - 1];
    final lastDayOfMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month + 1,
      0,
    ).day;
    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color.fromARGB(255, 0, 0, 0)
          : const Color.fromARGB(143, 149, 141, 179),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 59, 78),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            icon: isDarkMode
                ? Icon(Icons.light_mode_rounded)
                : Icon(Icons.dark_mode_rounded),
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Headline(selectedDate: widget.selectedDate),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 10.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color.fromARGB(172, 231, 189, 235)
                    : const Color.fromARGB(172, 22, 21, 21),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                widget.infoText,
                style: TextStyle(
                  color: isDarkMode ? Colors.black : Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: ladeHistorischeereignisse(
                  widget.selectedDate.month,
                  widget.selectedDate.day,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Fehler: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    final daten = snapshot.data!;
                    final ereignisse = daten['events'];
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final ereignis = ereignisse[index];
                        final jahr = ereignis['year'];
                        final ergebniss = ereignis['text'];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color.fromARGB(172, 231, 189, 235)
                                  : const Color.fromARGB(172, 22, 21, 21),
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              '$jahr: $ergebniss',
                              style: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color.fromARGB(172, 231, 189, 235)
                      : const Color.fromARGB(172, 22, 21, 21),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  style: TextStyle(
                    color: isDarkMode ? Colors.black : Colors.white,
                    fontSize: 15,
                  ),
                  'Heute ist der $formatiertesDatum und der $wochentag $wochentagName im Monat $monatName. Es ist der $tagImJahr. Tag im Jahr ${widget.selectedDate.year}. Der Monat hat $lastDayOfMonth Tage.',
                ),
              ),
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
          if (index == 0) {
            Navigator.pop(
              context,
            ); // Geht eine Seite zurück (zur Kalender-Seite)
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
      ),
    );
  }
}
