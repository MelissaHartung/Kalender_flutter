import 'package:flutter/material.dart';
import 'functions/headline.dart';
import 'functions/history_dates.dart';

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
      backgroundColor: const Color.fromARGB(143, 149, 141, 179),
      // appBar: AppBar(backgroundColor: const Color.fromARGB(255, 25, 53, 26)),
      body: SafeArea(
        child: Column(
          children: [
            Headline(
              selectedDate: widget.selectedDate,
              onPreviousMonth: widget.previousMonth,
              onNextMonth: widget.nextMonth,
            ),
            Container(
              padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 3),
              borderRadius: BorderRadius.circular(100)
            ),
              child: Text(widget.infoText, style: const TextStyle(color: Colors.white, fontSize: 15),  textAlign: TextAlign.center,
              )),
            Expanded(
              child: FutureBuilder(future:ladeHistorischeereignisse(widget.selectedDate.month, widget.selectedDate.day), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Fehler: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final daten= snapshot.data!;
                 final ereignisse = daten['events'];
                return ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                final ereignis = ereignisse[index];
                final jahr = ereignis['year'];
                final ergebniss = ereignis['text'];
                return Padding  (
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(174, 0, 0, 0),
                      border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 3),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Text('$jahr: $ergebniss',
                    style: const TextStyle(color: Colors.white, fontSize: 15),  textAlign: TextAlign.center,
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
