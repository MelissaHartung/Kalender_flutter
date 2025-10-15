import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final List<Duration> durations = [
    const Duration(minutes: 5),
    const Duration(minutes: 15),
    const Duration(minutes: 30),
    const Duration(minutes: 45),
    const Duration(hours: 1),
    const Duration(hours: 1, minutes: 30),
  ];
  bool get _isCustomDurationSelected{
    if (_selectedDuration==null){
      return false;
    }
    return !durations.contains(_selectedDuration);
  }
   
   Future<void> _showCustomDurationDialog() async {
    final customDurationController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogcontext) {
        return AlertDialog(
          title: const Text('Benutzerdefinierte Dauer eingeben (Minuten)'),
          content: TextField(
            controller: customDurationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'z.B. 20 für 20 Minuten'),
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
                final int? minutes = int.tryParse(customDurationController.text);
                if (minutes != null && minutes > 0) {
                  setState(() {
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
  DateTime?_selectedTime;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Add To-Do'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(padding:  EdgeInsets.all(16.0),

      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'To-Do Title',
            ),
          ),
          SizedBox(height: 20),
          TextButton.icon(icon:const Icon(Icons.timer_outlined,size: 25,), label: Text(_selectedTime==null?'uhrzeit auswählen': DateFormat('HH:mm').format(_selectedTime!)), onPressed: ()  { showModalBottomSheet(context: context, builder: (BuildContext context){
            return SizedBox(height: 450,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(initialDateTime: DateTime.now(), mode: CupertinoDatePickerMode.time, use24hFormat: true, onDateTimeChanged: (DateTime newTime){
                      setState(() {
                        _selectedTime = newTime;
                      });
                    }),
                  ),
              const Divider(thickness: 1),const SizedBox(height: 10,),
                  const Text('Dauer auswählen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Wrap(spacing:8.0,runSpacing: 4.0,children: [
                    ...durations.map((duration) {
                      final isSelected = _selectedDuration == duration;
                      return
                    ActionChip(label: Text('${duration.inMinutes} Min'), onPressed: (){
                      setState(() {
                        _selectedDuration = duration;
                      });
                      },
                    
                    backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    );
                        }).toList(),
                        OutlinedButton(onPressed: (){_showCustomDurationDialog();},style: OutlinedButton.styleFrom(foregroundColor: _isCustomDurationSelected ? Colors.blue : const Color.fromARGB(255, 0, 0, 0), side: BorderSide(color: _isCustomDurationSelected ? Colors.blue : const Color.fromARGB(255, 0, 0, 0), width: 2.0)), child: const Text('Benutzerdefiniert'))
                  ]
                )
                ],
                
              ),
            ),
            );
          }
          );
          },),

          ElevatedButton(
            onPressed: () {
              // Logic to add the to-do item
              Navigator.pop(context);
            },
            child: Text('Add To-Do'),
          ),
        ],
      ),
    )
    );
  }
}