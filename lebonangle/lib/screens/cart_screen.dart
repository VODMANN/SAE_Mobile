import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';

import '../models/cart.dart';
import '../models/products.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
        body: FutureBuilder(
            future: service.getCart('1'),
            builder: (BuildContext context, AsyncSnapshot<Cart?> cartSnapshot) {
              if (!cartSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (cartSnapshot.data == null) {
                return const Center(
                  child: Text('Aucun article dans le panier !'),
                );
              }

              final products = cartSnapshot.data!.products;
              return ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (_, index) {
                  final product = products[index];
                  return FutureBuilder(
                    future: service.getProduct(product['productId']),
                    builder: (BuildContext context,
                        AsyncSnapshot<Product?> productSnapshot) {
                      if (!productSnapshot.hasData) {
                        return const LinearProgressIndicator();
                      }

                      final p = productSnapshot.data;
                      if (p == null) {
                        return const Text("Aucun produit trouvé !");
                      }

                      return ListTile(
                        title: Text(p.title),
                        leading: Image.network(p.image ?? '', height: 40),
                        subtitle: Text('Quantité : ${product['quantity']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await service.deleteCart('1');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Produit supprimé")));
                          },
                        ),
                      );
                    },
                  );
                },
              );
            }));
  }
}
