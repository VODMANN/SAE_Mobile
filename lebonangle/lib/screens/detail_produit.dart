import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lebonangle/api_service.dart';

import '../intro_screens/products.dart';

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
        title: Text('lebonangle'),
        leading: IconButton(
          icon: Icon(
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
              return Center(
                  child: Image(
                width: 150,
                image: NetworkImage(product.image.toString()),
              ));
            }
          },
        ),
      ),
    );
  }
}
