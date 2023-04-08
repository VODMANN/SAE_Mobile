import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lebonangle/intro_screens/navbar.dart';
import 'package:lebonangle/models/products.dart';

class AjoutProduitPage extends StatefulWidget {
  const AjoutProduitPage({Key? key}) : super(key: key);

  @override
  _AjoutProduitPageState createState() => _AjoutProduitPageState();
}

class _AjoutProduitPageState extends State<AjoutProduitPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  Future<void> _addProduct() async {
    final produit = Product(
      id: int.parse(_idController.text),
      title: _titleController.text,
      price: double.parse(_priceController.text),
      description: _descriptionController.text,
      category: _categoryController.text,
      image: _imageController.text,
    );

    await FirebaseFirestore.instance
        .collection('produits')
        .add(produit.toJson());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID'),
                controller: _idController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Veuillez entrer un ID valide';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titre'),
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prix'),
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un prix valide';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: _descriptionController,
                maxLines: null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Catégorie'),
                controller: _categoryController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image'),
                controller: _imageController,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addProduct();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => navBar()),
                    );
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
