import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';
import 'package:lebonangle/models/product_view.dart';
import 'package:lebonangle/swipe.dart';
import 'package:provider/provider.dart';

import '../onboarding_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        ), // ajout de l'accollade fermante ici
      ],
      child: GetMaterialApp(
        scrollBehavior: MyScrollBehavior(),
        debugShowCheckedModeBanner: false,
        home: const OnBoardingScreen(),
      ),
    );
  }
}
