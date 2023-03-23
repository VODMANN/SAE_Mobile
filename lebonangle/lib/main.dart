import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lebonangle/screens/home/home_screen.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: pageIntro());
  }
}

// ignore: camel_case_types
class pageIntro extends StatelessWidget {
  const pageIntro({super.key});

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.network(
            'https://img.freepik.com/vecteurs-libre/illustration-coloree-du-programmeur-travaillant_23-2148281410.jpg?w=740&t=st=1679519588~exp=1679520188~hmac=122e501e6c69e1c91a597bf47714ccdc691a7ad974cea6da178831c091d2ae3f'),
        title: 'Bienvenue sur LeBonAngle',
        body: "L'application pour acheter et vendre tes articles !",
      ),
      PageViewModel(
        image: Image.network(
            'https://img.freepik.com/photos-premium/homme-meconnaissable-tenant-sac-provisions_236854-22048.jpg?w=900'),
        title: 'Vente',
        body:
            "Est-tu prêt à faire le tri dans tes affaires ? \n Alors n'attends plus un instant pour ventre tes articles !",
      ),
      PageViewModel(
        image: Image.network(
            'https://img.freepik.com/photos-gratuite/ventes-achats-du-cyber-monday_23-2148688502.jpg?w=740&t=st=1679520754~exp=1679521354~hmac=adb42f272431c5fb2c5545b633e156659fcaed218f801dbb659b21597941ebe3'),
        title: 'Achat',
        body:
            "Avec Lebonangle, trouve la bonne affaire. \n Notre site dispose de centaines d'annonces pour te permettre de trouver ton bonheur !",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IntroductionScreen(
          pages: getPages(),
          showSkipButton: true,
          skip: const Text("Passer"),
          next: const Text("Prochain"),
          done: const Text("Compris"),
          onDone: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageProduit()),
            );
          },
          baseBtnStyle: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
          ),
          skipStyle: TextButton.styleFrom(foregroundColor: Colors.red),
          doneStyle: TextButton.styleFrom(foregroundColor: Colors.green),
          nextStyle: TextButton.styleFrom(foregroundColor: Colors.blue),
        ),
      ),
    );
  }
}

class PageProduit extends StatelessWidget {
  const PageProduit({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.blue,
        fontFamily: "Gordita",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
