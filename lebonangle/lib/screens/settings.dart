// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebonangle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/my_app.dart';

class pageSettings extends StatefulWidget {
  const pageSettings({super.key});

  @override
  State<pageSettings> createState() => _pageSettingsState();
}

class _pageSettingsState extends State<pageSettings> {
  bool isChecked = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  getValue() async {
    prefs = await _prefs;
    setState(() {
      isChecked = (prefs.containsKey("checkedValue")
          ? prefs.getBool("checkedValue")
          : false)!;
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

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
              print(isChecked);
            });
            prefs.setBool("checkedValue", isChecked);
            Get.to(MyApp());
          },
        ),
      ),
    );
  }
}
