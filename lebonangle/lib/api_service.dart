import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lebonangle/intro_screens/products.dart';

class ApiService {
  Future<List<Product?>?> getProducts() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Product?>? _model = productFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}