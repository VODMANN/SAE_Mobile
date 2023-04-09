import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_skfh9odt.json',
                height: 350,
                width: 350),
            const Text("Et vendez ceux que vous n'utilisez plus")
          ],
        ),
      ),
    );
  }
}
