// ignore_for_file: prefer_const_constructors

/* // ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';

import '../models/products.dart';

class DetailProduitScreen extends StatelessWidget {
  const DetailProduitScreen({super.key, required this.id});

  final int id;
  ApiService get service => GetIt.I<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('lebonangle'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: service.getProduct(id),
          builder: (BuildContext context, AsyncSnapshot<Product?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final product = snapshot.data;

            if (product == null) {
              return const Center(
                child: Text(
                  'Aucun produit trouvé !',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                    child: Column(
                  children: [
                    Image(
                      width: 150,
                      image: NetworkImage(product.image.toString()),
                    ),
                    Text(product.title.toString()),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        product.description.toString(),
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(product.price.toString() + '€'),
                            ElevatedButton.icon(
                              onPressed: () async {
                                // Respond to button press
                                await service.updateCart(1, product.id.toInt());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal),
                              icon:
                                  const Icon(Icons.add_shopping_cart, size: 18),
                              label: const Text("Ajouter au panier"),
                            )
                          ],
                        )),
                  ],
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import '../models/product_view.dart';
import '../models/products.dart';

class DetailProduit extends StatelessWidget {
  final Product product;

  DetailProduit({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(product.title),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 200.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Prix: ${product.price} FCFA',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text(
              product.description,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
