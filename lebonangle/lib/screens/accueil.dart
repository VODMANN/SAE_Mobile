// ignore_for_file: prefer_interpolation_to_compose_strings, camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lebonangle/screens/detail_produit.dart';
import 'package:provider/provider.dart';
import '../models/product_view.dart';
import '../models/products.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  // instance de Firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        // Stream qui écoute les changements de la collection 'produits'
        stream: _db.collection('produits').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Liste des documents dans la collection 'produits'
            final products = snapshot.data!.docs;

            // Construire une liste de cartes de produits à partir des documents
            List<Widget> productCards = products
                .map(
                  (product) => Card(
                    child: GestureDetector(
                      onTap: () {
                        // Naviguer vers la page de détail du produit correspondant
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProduit(
                              product: Product.fromSnapshot(product),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(child: Image.network(
                            (product.data() as Map<String, dynamic>)['image']
                                .toString(),
                          ),),
                          ListTile(
                            title: Text(
                                (product.data() as Map<String, dynamic>)['title']
                                    .toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList();

            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: productCards,
            );
          }
        },
      ),
    );
  }
}



/* // class pageAccueil extends StatefulWidget {
//   const pageAccueil({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// var isSelected = false;
// var icon = Icons.favorite_border;

// class _HomeState extends State<pageAccueil> {
//   late List<Product> produits;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _userModel == null || _userModel!.isEmpty
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2),
//                 itemCount: _userModel!.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               DetailProduitScreen(id: index + 1),
//                         ),
//                       );
//                     },
//                     child: Card(
//                         clipBehavior: Clip.antiAlias,
//                         child: Column(children: [
//                           Center(
//                             child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Text(
//                                   _userModel![index].title.toString(),
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Image(
//                               image: NetworkImage(
//                                   _userModel![index].image.toString()),
//                             ),
//                           ),
//                           Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Text(
//                                 _userModel![index].category.toString(),
//                                 style: TextStyle(
//                                     color: Colors.black.withOpacity(0.6)),
//                               ),
//                             ),
//                           ),
//                           Center(
//                               child: Text(
//                                   _userModel![index].price.toString() + "€")),
//                           IconButton(
//                             icon: Icon(icon),
//                             color: Colors.red,
//                             onPressed: () {
//                               // Respond to icon toggle
//                               setState(() {
//                                 isSelected = !isSelected;
//                                 icon = isSelected
//                                     ? Icons.favorite
//                                     : Icons.favorite_border;
//                               });
//                             },
//                           )
//                         ])),
//                   );
//                 },
//               ),
//         floatingActionButton: FloatingActionButton(
//             backgroundColor: Colors.teal,
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const CartScreen(),
//                   ));
//             },
//             child: const Icon(Icons.shopping_cart_outlined)));
//   }
// } */