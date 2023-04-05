// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/screens/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lebonangle/api_service.dart';
import 'package:lebonangle/intro_screens/navbar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController nameCtrl = TextEditingController(text: 'mor_2314');
  final TextEditingController passwordCtrl =
      TextEditingController(text: '83r5^_');

  ApiService get service => GetIt.I<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            Padding(padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  final getToken = await service.login(
                    nameCtrl.text,
                    passwordCtrl.text,
                  );

                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('username', nameCtrl.text);
                  Get.to(const navBar());
                  Get.to(const UserScreen());

                  if (getToken != null && getToken['token'] != null) {

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('username', nameCtrl.text);
                                     
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Vous êtes connecté'),
                      backgroundColor: Colors.teal,
                    ),);
                    Future.delayed(
                        const Duration(seconds: 2),
                        () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const navBar(),
                              ),
                            ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Mot de passe invalide'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text('Se connecter'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
