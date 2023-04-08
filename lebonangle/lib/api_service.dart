import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:lebonangle/models/products.dart';

class ApiService {
  static List<Product?> allProducts = [];

  void getProducts() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Product> model = productFromJson(response.body);
        if (model != null) {
          addProduct(model);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void addProduct(List<Product> model) {
    // Reference de la collection "produits" dans Firestore
    CollectionReference products =
        FirebaseFirestore.instance.collection('produits');
    for (int i = 0; i < model.length; i++) {
      Product? product = model[i];
      if (product != null) {
        products.add({
          "id": product.id,
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "category": product.category,
          "image": product.image,
        }).then((value) {
          print("Produit ajouté avec l'ID : ${value.id}");
        }).catchError((error) {
          print("Erreur lors de l'ajout du produit : $error");
        });
      }
    }

    // Ajouter les données du produit à la collection "produits"
  }
}
