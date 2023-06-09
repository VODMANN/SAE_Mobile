// ignore_for_file: prefer_interpolation_to_compose_strings, camel_case_types, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lebonangle/screens/detail_produit.dart';
import 'package:lebonangle/screens/panier_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  // instance de Firestore
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

  void _addToFavoris(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final favorisString = prefs.getString('favoris');
    List<Product> favoris = [];

    if (favorisString != null) {
      final favorisJson = json.decode(favorisString);
      favoris = favorisJson
          .map((favori) => Product.fromJson(favori))
          .toList()
          .cast<Product>();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Produit ajouté aux favoris !')));
    }

    if (favoris.any((favori) => favori.id == product.id)) {
      return;
    }

    favoris.add(product);
    final favorisJson = json.encode(favoris);
    await prefs.setString('favoris', favorisJson);

    // Vérifier si le completer n'a pas encore été utilisé
    if (!_primaryCompleter.isCompleted) {
      _primaryCompleter.complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        // Stream qui écoute les changements de la collection 'produits'
        stream: _db.collection('produits').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Liste des documents dans la collection 'produits'
            final products = snapshot.data!.docs;

            // Construire une liste de cartes de produits à partir des documents
            List<Widget> productCards = products
                .map(
                  (product) => Card(
                    child: GestureDetector(
                      onTap: () {
                        // Naviguer vers la page de détail du produit correspondant
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProduit(
                              product: Product.fromSnapshot(product),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              (product.data() as Map<String, dynamic>)['image']
                                  .toString(),
                              width: 75,
                            ),
                          ),
                          ListTile(
                            title: Text((product.data()
                                    as Map<String, dynamic>)['title']
                                .toString()),
                          ),
                          // bouton pour ajouter le produit aux favoris
                          ElevatedButton(
                            onPressed: () {
                              final productData = Product.fromSnapshot(product);
                              _addToFavoris(productData);
                            },
                            child: const Text('Ajouter aux favoris'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList();

            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: productCards,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PanierPage()),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
