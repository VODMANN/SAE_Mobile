// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lebonangle/main.dart';

// ignore_for_file: camel_case_types

class pageSettings extends StatefulWidget {
  const pageSettings({super.key});

  @override
  State<pageSettings> createState() => _pageSettingsState();
}

class _pageSettingsState extends State<pageSettings> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CheckboxListTile(
          title: Text("Introduction"),
          subtitle:
              Text("Souhaitez vous passer l'introduction à chaque démarrage ?"),
          value: isChecked,
          onChanged: (bool? value) {
            if (isChecked == true) {}
            setState(() {
              isChecked = value!;
            });
          },
        ),
      ),
    );
  }
}
