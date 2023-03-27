import 'package:flutter/material.dart';

// ignore_for_file: camel_case_types

class pageSettings extends StatefulWidget {
  const pageSettings({super.key});

  @override
  State<pageSettings> createState() => _pageSettingsState();
}

class _pageSettingsState extends State<pageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("coucou"),
      ),
    );
  }
}
