// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lebonangle/screens/accueil.dart';
import 'package:lebonangle/screens/settings.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    pageAccueil(),
    Text(
      "Favoris",
      style: optionStyle,
    ),
    Text(
      "Publier",
      style: optionStyle,
    ),
    Text(
      "Profile",
      style: optionStyle,
    ),
    pageSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('lebonangle'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.teal,
              gap: 8,
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
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
