import 'package:flutter/material.dart';

class Notizen extends StatefulWidget {
  const Notizen({super.key});

  @override
  State<Notizen> createState() => _NotizenState();
}

class _NotizenState extends State<Notizen> {
  final TextEditingController controller = TextEditingController();
  bool isEditing = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextField(controller: controller)),
    );
  }
}
