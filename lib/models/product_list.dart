import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shopapp-1a4cc-default-rtdb.firebaseio.com/';
  // Constants.productBaseUrl;

  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    print('Data received: $data');
    bool hasId = data['id'] != null;

    try {
      // Verificando se os campos não são nulos e são do tipo esperado
      if (data['name'] == null || data['name'] is! String) {
        throw 'Invalid name type';
      }
      if (data['description'] == null || data['description'] is! String) {
        throw 'Invalid description type';
      }
      if (data['imageUrl'] == null || data['imageUrl'] is! String) {
        throw 'Invalid imageUrl type';
      }

      final double price;
      if (data['price'] is double) {
        price = data['price'] as double;
      } else if (data['price'] is int) {
        price = (data['price'] as int).toDouble();
      } else {
        price = double.tryParse(data['price'].toString()) ?? 0.0;
      }

      final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        name: data['name'] as String,
        description: data['description'] as String,
        price: price,
        imageUrl: data['imageUrl'] as String,
      );

      if (hasId) {
        await updateProduct(product);
      } else {
        await addProduct(product);
      }
    } catch (e) {
      print('Error casting data: $e');
      print(
          'Data types: ${data.map((key, value) => MapEntry(key, value.runtimeType))}');
      return Future.error('Invalid data');
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}

// Produto
