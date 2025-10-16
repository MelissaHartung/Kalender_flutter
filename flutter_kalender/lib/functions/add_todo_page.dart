import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kalender/functions/to_do.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  final DateTime date;
  const AddTodoPage({super.key, required this.date});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _todoTitleController = TextEditingController();
  final List<Duration> durations = [
    const Duration(minutes: 5),
    const Duration(minutes: 15),
    const Duration(minutes: 30),
    const Duration(minutes: 45),
    const Duration(hours: 1),
    const Duration(hours: 1, minutes: 30),
  ];
  bool get _isCustomDurationSelected {
    if (_selectedDuration == null) {
      return false;
    }
    return !durations.contains(_selectedDuration);
  }

  Future<void> _showCustomDurationDialog(StateSetter sheetSetState) async {
    final customDurationController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogcontext) {
        return AlertDialog(
          title: const Text('Benutzerdefinierte Dauer eingeben (Minuten)'),
          content: TextField(
            controller: customDurationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'z.B. 20 für 20 Minuten',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                final int? minutes = int.tryParse(
                  customDurationController.text,
                );
                if (minutes != null && minutes > 0) {
                  sheetSetState(() {
                    _selectedDuration = Duration(minutes: minutes);
                  });
                }
                Navigator.of(dialogcontext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Duration? _selectedDuration;
  DateTime? _selectedTime;

  @override
  void dispose() {
    // Diese Methode wird aufgerufen, wenn die Seite zerstört wird.
    // Räume hier immer deine Controller auf!
    _todoTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: EdgeInsets.only(top: 100, left: 16.0, right: 16.0),

        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 82, 81, 81),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),

            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _todoTitleController,
                    decoration: InputDecoration(
                      labelText: 'To-Do',
                      labelStyle: TextStyle(color: Colors.grey),

                      border: InputBorder.none,
                    ),
                  ),
                  Divider(color: Colors.grey[700]),
                  TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    icon: const Icon(Icons.timer_outlined, size: 25),
                    label: Text(
                      _selectedTime == null
                          ? 'Zeit'
                          : DateFormat('HH:mm').format(_selectedTime!),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter sheetSetState) {
                              return SizedBox(
                                height: 450,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          initialDateTime: DateTime.now(),
                                          mode: CupertinoDatePickerMode.time,
                                          use24hFormat: true,
                                          onDateTimeChanged: (DateTime newTime) {
                                            setState(() {
                                              // Das normale setState ist hier OK, da die Uhrzeit auch außerhalb sichtbar ist
                                              _selectedTime = newTime;
                                            });
                                          },
                                        ),
                                      ),
                                      const Divider(thickness: 1),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Dauer auswählen',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        children: [
                                          ...durations.map((duration) {
                                            final isSelected =
                                                _selectedDuration == duration;
                                            return ActionChip(
                                              label: Text(
                                                '${duration.inMinutes} Min',
                                              ),
                                              onPressed: () {
                                                sheetSetState(() {
                                                  // Hier das sheetSetState benutzen
                                                  _selectedDuration = duration;
                                                });
                                              },
                                              backgroundColor: isSelected
                                                  ? Colors.blue
                                                  : Colors.grey[300],
                                              labelStyle: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            );
                                          }).toList(),
                                          OutlinedButton(
                                            onPressed: () {
                                              _showCustomDurationDialog(
                                                sheetSetState,
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  _isCustomDurationSelected
                                                  ? Colors.blue
                                                  : const Color.fromARGB(
                                                      255,
                                                      0,
                                                      0,
                                                      0,
                                                    ),
                                              side: BorderSide(
                                                color: _isCustomDurationSelected
                                                    ? Colors.blue
                                                    : const Color.fromARGB(
                                                        255,
                                                        0,
                                                        0,
                                                        0,
                                                      ),
                                                width: 2.0,
                                              ),
                                            ),
                                            child: _isCustomDurationSelected
                                                // Hier greifen wir auf die Minuten der ausgewählten Dauer zu
                                                ? Text(
                                                    '${_selectedDuration!.inMinutes} Min',
                                                  )
                                                : const Text(
                                                    'Benutzerdefiniert',
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String todoTitle = _todoTitleController.text;
                if (todoTitle.isNotEmpty) {
                  DateTime? finalDateTime;
                  if (_selectedTime != null) {
                    final date = widget.date;
                    final time = _selectedTime!;
                    finalDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                  }
                  final newTodo = ToDo(
                    title: todoTitle,
                    starttime: finalDateTime,
                    duration: _selectedDuration,
                  );
                  Navigator.pop(context, newTodo);
                }
              },
              child: Text('Hinzufügen'),
            ),
          ],
        ),
      ),
    );
  }
}
