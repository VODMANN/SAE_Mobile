import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';
import 'package:lebonangle/intro_screens/navbar.dart';
import 'package:lebonangle/models/product_view.dart';
import 'package:lebonangle/swipe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding_screen.dart';
import '../screens/settings.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showIntroPages = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showIntroPages = prefs.getBool('showIntroPages') ?? true;
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showIntroPages', showIntroPages);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            ProduitView produitView = ProduitView();
            produitView.generateProduit();
            return produitView;
          },
        ),
      ],
      child: GetMaterialApp(
        scrollBehavior: MyScrollBehavior(),
        debugShowCheckedModeBanner: false,
        home: showIntroPages ? const OnBoardingScreen() : const navBar(),
        // Utilisation de l'opérateur ternaire pour choisir l'écran initial en fonction de la valeur de showIntroPages
        routes: {
          // Définition des routes
          '/settings': (_) => SettingsPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          // Gestionnaire de routes personnalisé
          switch (settings.name) {
            case '/settings':
              return MaterialPageRoute(builder: (_) => SettingsPage());
            default:
              // Si la route demandée n'existe pas, on affiche l'écran d'accueil
              return MaterialPageRoute(
                  builder: (_) => showIntroPages
                      ? const OnBoardingScreen()
                      : const navBar());
          }
        },
      ),
    );
  }
}
