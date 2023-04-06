// // ignore_for_file: prefer_interpolation_to_compose_strings, camel_case_types, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:lebonangle/models/products.dart';
// import 'package:lebonangle/api_service.dart';
// import 'package:lebonangle/screens/cart_screen.dart';
// import 'detail_produit.dart';
// import 'package:lebonangle/models/product_view.dart';

// class pageAccueil extends StatefulWidget {
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
// }
import 'package:flutter/material.dart';
import 'package:lebonangle/screens/detail_produit.dart';
import 'package:provider/provider.dart';

import '../models/product_view.dart';
import '../models/products.dart';

// class pageAccueil extends StatelessWidget {
//   late List<Product> produits;
//   String tags = '';

//   pageAccueil({super.key});
//   @override
//   Widget build(BuildContext context) {
//     produits = [
//       Product(
//           id: 1,
//           title: "test",
//           price: 45,
//           description: "sfgsdgsdb",
//           category: "dgdsfgd",
//           image: "link")
//     ];
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: produits.length,
//       itemBuilder: (context, index) => buildImageCard(context, index),
//     );
//   }

//   buildImageCard(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DetailProduitScreen(id: index)));
//       },
//       child: Card(
//           margin: const EdgeInsets.all(10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 produits[index].image.toString(),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           )),
//     );
//   }
// }
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
      appBar: AppBar(
        title: Text('Liste des produits'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Stream qui écoute les changements de la collection 'produits'
        stream: _db.collection('produits').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Liste des documents dans la collection 'produits'
            final products = snapshot.data!.docs;

            // Construire une liste de titres de produits à partir des documents
            List<Widget> productTitles = products
                .map(
                  (product) => ListTile(
                    title: Text(
                        (product.data() as Map<String, dynamic>)['title']
                            .toString()),
                  ),
                )
                .toList();

            return ListView(
              children: productTitles,
            );
          }
        },
      ),
    );
  }
}
