// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';
import 'package:lebonangle/screens/accueil.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController nameCtrl = TextEditingController(text: 'leseaux');
  final TextEditingController passwordCtrl =
      TextEditingController(text: 'test');

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
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
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
                  if (getToken != null && getToken['token'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Vous êtes connecté'),
                      backgroundColor: Colors.teal,
                    ));
                    Future.delayed(
                        const Duration(seconds: 2),
                        () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const pageAccueil(),
                              ),
                            ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Mot de passe invalide'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text('Se connecter'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
