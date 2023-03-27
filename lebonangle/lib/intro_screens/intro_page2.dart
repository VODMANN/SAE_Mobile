import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  _IntroPage2 createState() => _IntroPage2();
}

class _IntroPage2 extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_uqs1ib9v.json'),
      ),
    );
  }
}
