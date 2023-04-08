import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Product> productFromJson(String str) => json.decode(str) == null
    ? []
    : List<Product>.from(json.decode(str)!.map((x) => Product.fromJson(x)));

class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  int id;
  String title;
  double price;
  String description;
  String category;
  String image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
      };

  static Future<List<Product>> getFirebaseProduits() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("produits").get();
    List<Product> produits = [];
    for (var element in querySnapshot.docs) {
      produits.add(
        Product.nouveauProduit(
          id: element['id'],
          title: element['title'],
          price: element['price'],
          description: element['description'],
          image: element['images'],
          category: element['category'],
        ),
      );
    }
    return produits;
  }

  static Product fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Product(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      price: data['price'],
      description: data['description'],
      category: data['category'],
    );
  }

  static nouveauProduit(
      {required id,
      required title,
      required price,
      required description,
      required image,
      required category}) {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      image: image,
      category: category,
    );
  }
}
