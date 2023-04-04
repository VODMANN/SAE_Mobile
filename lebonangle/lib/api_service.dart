// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lebonangle/models/cart_update.dart';
import 'package:lebonangle/models/products.dart';

import 'models/cart.dart';
import 'models/user_login.dart';

class ApiService {
  Future<List<Product?>?> getProducts() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Product?>? model = productFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
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
