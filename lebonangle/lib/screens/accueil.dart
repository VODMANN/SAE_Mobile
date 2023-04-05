// ignore_for_file: prefer_interpolation_to_compose_strings, camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lebonangle/models/products.dart';
import 'package:lebonangle/api_service.dart';
import 'package:lebonangle/screens/cart_screen.dart';
import 'detail_produit.dart';

class pageAccueil extends StatefulWidget {
  const pageAccueil({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

var isSelected = false;
var icon = Icons.favorite_border;

class _HomeState extends State<pageAccueil> {
  late List<Product>? _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getProducts())!.cast<Product>();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _userModel == null || _userModel!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _userModel!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailProduitScreen(id: index + 1),
                        ),
                      );
                    },
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(children: [
                          Center(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  _userModel![index].title.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Expanded(
                            child: Image(
                              image: NetworkImage(
                                  _userModel![index].image.toString()),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _userModel![index].category.toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ),
                          Center(
                              child: Text(
                                  _userModel![index].price.toString() + "€")),
                          IconButton(
                            icon: Icon(icon),
                            color: Colors.red,
                            onPressed: () {
                              // Respond to icon toggle
                              setState(() {
                                isSelected = !isSelected;
                                icon = isSelected
                                    ? Icons.favorite
                                    : Icons.favorite_border;
                              });
                            },
                          )
                        ])),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ));
            },
            child: const Icon(Icons.shopping_cart_outlined)));
  }
}
