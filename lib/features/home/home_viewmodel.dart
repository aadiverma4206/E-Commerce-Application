import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductService _productService;

  HomeViewModel({ProductService? productService})
      : _productService = productService ?? ProductService();

  Stream<List<ProductModel>> get productsStream {
    return _productService.getProducts();
  }
}