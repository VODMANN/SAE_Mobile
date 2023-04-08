// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lebonangle/screens/detail_produit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/products.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({Key? key}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<Product> _panier = [];

  @override
  void initState() {
    super.initState();
    _loadpanier();
  }

  void _loadpanier() async {
    final prefs = await SharedPreferences.getInstance();
    final panierString = prefs.getString('panier');
    if (panierString != null) {
      final panierJson = json.decode(panierString);
      final panier = panierJson
          .map((favori) => Product.fromJson(favori))
          .toList()
          .cast<Product>();
      setState(() {
        _panier = panier;
      });
    }
  }

  void _removeFrompanier(Product product) async {
    final index = _panier.indexOf(product);
    setState(() {
      _panier.remove(product);
    });

    final prefs = await SharedPreferences.getInstance();
    final panierJson = _panier.map((favori) => favori.toJson()).toList();
    final panierString = json.encode(panierJson);
    await prefs.setString('panier', panierString);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Produit supprimé des panier.'),
        action: SnackBarAction(
          label: 'Annuler',
          onPressed: () {
            setState(() {
              _panier.insert(index, product);
            });
            prefs.setString('panier',
                json.encode(_panier.map((favori) => favori.toJson()).toList()));
          },
        ),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0.0;
    for (final product in _panier) {
      total += product.price;
    }
    return double.parse(total.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    if (_panier.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('Panier'),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: _panier.length,
                itemBuilder: (context, index) {
                  final product = _panier[index];
                  return ListTile(
                    leading: Image.network(
                      product.image,
                      width: 75,
                    ),
                    title: Text(product.title),
                    subtitle: Text('${product.price} €'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeFrompanier(product),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProduit(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Total: ${_calculateTotal()} €',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('panier');
                  setState(() {
                    _panier.clear();
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Panier validé.'),
                    ),
                  );
                },
                child: const Text('Valider le panier'),
              ),
            )
          ]));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Panier'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(
          child: Text('Aucun produit ajouté aux panier.'),
        ),
      );
    }
  }
}
