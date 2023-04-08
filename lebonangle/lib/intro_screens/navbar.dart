// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lebonangle/screens/accueil.dart';
import 'package:lebonangle/screens/login_screen.dart';
import 'package:lebonangle/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service.dart';
import '../models/products.dart';
import '../screens/favoris_page.dart';
import '../screens/user_screen.dart';

String? finalName;

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int _selectedIndex = 0;

  late List<Product>? _userModel = [];

/* Fonction permettant de générer les produits de l'api FakeStore et de les mettre sur la BD Firebase */
/*   @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    print('Chargement des produits en cours...');
    ApiService apiService = ApiService();
    apiService.getProducts();
  } */

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    Accueil(),
    FavorisPage(),
    Text(
      "Publier",
      style: optionStyle,
    ),
    UserScreen(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('lebonangle'),
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
