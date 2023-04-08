import 'package:flutter/cupertino.dart';
import 'package:lebonangle/models/products.dart';

class ProduitView extends ChangeNotifier {
  late List<Product> liste;
  ProduitView() {
    liste = [];
  }
  void addProduit(Product produit) {
    liste.add(produit);
    notifyListeners();
  }

  void generateProduit() async {
    liste = await Product.getFirebaseProduits();
    notifyListeners();
  }

  void deleteProduit(int id) {
    liste.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateProduit(Product produit) {
    liste.removeWhere((element) => element.id == produit.id);
    liste.add(produit);
    notifyListeners();
  }

  Future<List<Product>> getProduits() async {
    return liste;
  }

  getProduitBySearch(String searchText) {
    return liste
        .where((element) => element.title.contains(searchText))
        .toList();
  }
}
