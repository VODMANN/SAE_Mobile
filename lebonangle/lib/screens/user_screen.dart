import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebonangle/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalName;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

Future getValidationData() async{
    final SharedPreferences sharedPreferences = 
      await SharedPreferences.getInstance();
    var obtainedName = sharedPreferences.getString('username');
    setState(() {
      finalName = obtainedName;
    });
    print(finalName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialButton(
        color: Colors.red,
        onPressed: () async {
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.remove('username');
          Get.to(LoginScreen());
        },
        child: const Text("Se déconnecter"),
      )
    );
  }
}