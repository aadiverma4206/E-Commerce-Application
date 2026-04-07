import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  Stream<List<ProductModel>> getProducts() {
    return _productService.getProducts();
  }
}