import 'package:flutter/material.dart';
import 'package:lebonangle/intro_screens/products.dart';
import 'package:lebonangle/api_service.dart';
import 'detail_produit.dart';

class pageAccueil extends StatefulWidget {
  const pageAccueil({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

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
          : ListView.builder(
              itemCount: _userModel!.length,
              itemBuilder: (context, index) {
                return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(children: [
                      Image(
                        width: 200,
                        image:
                            NetworkImage(_userModel![index].image.toString()),
                      ),
                      ListTile(
                        title: Text(_userModel![index].title.toString() +
                            " " +
                            _userModel![index].price.toString() +
                            "€"),
                        subtitle: Text(
                          _userModel![index].category.toString(),
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailProduitScreen(id: index + 1),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _userModel![index].description.toString(),
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ]));
              },
            ),
    );
  }
}
