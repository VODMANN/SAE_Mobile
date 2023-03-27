// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class pageAccueil extends StatefulWidget {
  const pageAccueil({super.key});

  @override
  State<pageAccueil> createState() => _pageAccueilState();
}

class _pageAccueilState extends State<pageAccueil> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("c'est moi l'accueil"),
      ),
    );
  }
}
