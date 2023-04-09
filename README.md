# Récapitulatif de l'application
L'application développée est une marketplace de vente d'objets d'occasion nommée "LeBonAngle". Les utilisateurs peuvent vendre des produits en créant des annonces avec des informations sur le produit et des images. Les acheteurs peuvent parcourir les annonces et effectuer des achats.

## Fonctionnalités

### Parcourir les annonces
Les utilisateurs peuvent parcourir les annonces publiées par d'autres utilisateurs. Les annonces sont stockées dans Cloud Firestore. Les utilisateurs peuvent trier les annonces par catégorie, prix ou date de publication. Les annonces sont affichées avec une image, un titre, un prix et une brève description.

### Créer une annonce
Les utilisateurs peuvent créer une annonce en entrant des informations sur le produit, telles que le titre, le prix, la description, la catégorie et les images. Les images sont stockées dans Firebase Storage et les informations sur le produit sont stockées dans Cloud Firestore.

### Acheter un produit
Les utilisateurs peuvent acheter des produits en ajoutant des produits à leur panier et en passant une commande. Les informations de commande sont stockées dans Cloud Firestore.

## Packages utilisés

- `cupertino_icons: ^1.0.2`
- `smooth_page_indicator: ^1.0.0`
- `lottie: ^2.3.0`
- `firebase_core: ^2.8.0`
- `firebase_auth: ^4.3.0`
- `firebase_storage: ^11.0.16`
- `cloud_firestore: ^4.4.5`
- `cloud_functions: ^4.0.13`
- `google_nav_bar: ^5.0.6`
- `http: ^0.13.5`
- `get_it: ^7.2.0`
- `get: ^4.6.5`
- `shared_preferences: ^2.1.0`
- `provider: ^6.0.5`

## Conclusion
L'application est entièrement fonctionnelle et fournit une plateforme conviviale pour la vente et l'achat d'objets d'occasion. L'utilisation de Firebase facilite la mise en œuvre de fonctionnalités telles que l'authentification, le stockage de données et le traitement des commandes. L'interface utilisateur est intuitive et facile à naviguer, offrant une expérience utilisateur agréable pour les acheteurs et les vendeurs.
