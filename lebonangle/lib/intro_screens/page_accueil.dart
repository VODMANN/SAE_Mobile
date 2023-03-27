// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lebonangle/screens/settings.dart';

class pageAccueil extends StatefulWidget {
  const pageAccueil({super.key});

  @override
  State<pageAccueil> createState() => _pageAccueilState();
}

class _pageAccueilState extends State<pageAccueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.green.shade500,
            gap: 8,
            onTabChange: (index) {
              print(index);
            },
            padding: const EdgeInsets.all(4),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Accueil',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favoris',
              ),
              GButton(
                icon: Icons.add_box_outlined,
                text: 'Publier',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Profile',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Paramètres',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return pageSettings();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
