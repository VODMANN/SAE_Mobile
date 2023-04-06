import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:lebonangle/models/cart_update.dart';
import 'package:lebonangle/models/products.dart';

import 'models/cart.dart';
import 'models/user_login.dart';

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

  Future<Product?> getProduct(int id) async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Product.fromJson(jsonData);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Cart?> getCart(String id) async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/carts/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Cart.fromJson(jsonData);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> updateCart(int cartId, int productId) async {
    final cartUpdate =
        CartUpdate(userId: cartId, date: DateTime.now(), products: [
      {'productId': productId, 'quantity': 1}
    ]);
    return http
        .put(Uri.parse('https://fakestoreapi.com/carts/$cartId'),
            body: json.encode(cartUpdate.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }

  Future<void> deleteCart(String cartId) {
    return http
        .delete(Uri.parse('https://fakestoreapi.com/carts/$cartId'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }

  Future<dynamic> login(String username, String password) async {
    final credentials = UserLogin(username: username, password: password);
    return http
        .post(Uri.parse('https://fakestoreapi.com/auth/login'),
            body: credentials.toJson())
        .then((data) {
      if (data.statusCode == 200) {
        final jSonData = json.decode(data.body);
        return jSonData;
      }
    }).catchError((err) => print(err));
  }
}
