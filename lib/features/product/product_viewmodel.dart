import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';
import '../../core/utils/notification_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _service;

  ProductViewModel({ProductService? service})
    : _service = service ?? ProductService();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> upload(ProductModel product) async {
    _setLoading(true);
    _setError(null);

    try {
      await _service.uploadProduct(product);

      await NotificationService.showNotification(
        "🛍️ New Product",
        "${product.name} is now available",
      );
    } catch (_) {
      _setError("Failed to upload product");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }
}
