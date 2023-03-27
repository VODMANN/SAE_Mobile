import 'package:flutter/material.dart';
import 'package:lebonangle/swipe.dart';

import 'onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyScrollBehavior(),
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: OnBoardingScreen(),
    );
  }
}
