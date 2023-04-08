import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lebonangle/screens/detail_produit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/products.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({Key? key}) : super(key: key);

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  List<Product> _favoris = [];

  @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  void _loadFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final favorisString = prefs.getString('favoris');
    if (favorisString != null) {
      final favorisJson = json.decode(favorisString);
      final favoris = favorisJson
          .map((favori) => Product.fromJson(favori))
          .toList()
          .cast<Product>();
      setState(() {
        _favoris = favoris;
      });
    }
  }

  void _removeFromFavoris(Product product) async {
    final index = _favoris.indexOf(product);
    setState(() {
      _favoris.remove(product);
    });

    final prefs = await SharedPreferences.getInstance();
    final favorisJson = _favoris.map((favori) => favori.toJson()).toList();
    final favorisString = json.encode(favorisJson);
    await prefs.setString('favoris', favorisString);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Produit supprimé des favoris.'),
        action: SnackBarAction(
          label: 'Annuler',
          onPressed: () {
            setState(() {
              _favoris.insert(index, product);
            });
            prefs.setString(
                'favoris',
                json.encode(
                    _favoris.map((favori) => favori.toJson()).toList()));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _favoris.isNotEmpty
          ? ListView.builder(
              itemCount: _favoris.length,
              itemBuilder: (context, index) {
                final product = _favoris[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 75,
                  ),
                  title: Text(product.title),
                  subtitle: Text('${product.price} €'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeFromFavoris(product),
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
            )
          : const Center(
              child: Text('Aucun produit ajouté aux favoris.'),
            ),
    );
  }
}
