import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/products.dart';

class DetailProduit extends StatefulWidget {
  final Product product;

  DetailProduit({required this.product});

  @override
  _DetailProduitState createState() => _DetailProduitState();
}

class _DetailProduitState extends State<DetailProduit> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Completer<void> _primaryCompleter = Completer();

  // initialisation de SharedPreferences
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _addToPanier(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final panierString = prefs.getString('panier');
    List<Product> panier = [];

    if (panierString != null) {
      final panierJson = json.decode(panierString);
      panier = panierJson
          .map((favori) => Product.fromJson(favori))
          .toList()
          .cast<Product>();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Produit ajouté aux panier !')));
    }

    if (panier.any((favori) => favori.id == product.id)) {
      return;
    }

    panier.add(product);
    final panierJson = json.encode(panier);
    await prefs.setString('panier', panierJson);

    // Vérifier si le completer n'a pas encore été utilisé
    if (!_primaryCompleter.isCompleted) {
      _primaryCompleter.complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.product.title),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.product.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.product.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${widget.product.price} €',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addToPanier(widget.product);
                },
                child: Text('Ajouter au panier'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
