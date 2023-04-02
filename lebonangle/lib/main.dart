import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';
import 'package:lebonangle/swipe.dart';

import 'onboarding_screen.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ApiService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
    );
  }
}
