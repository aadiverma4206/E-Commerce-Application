import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';
import '../../core/utils/notification_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _service = ProductService();

  bool isLoading = false;
  String? error;

  Future<void> upload(ProductModel product) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _service.uploadProduct(product);

      await NotificationService.showNotification(
        "🛍️New Product🛍️",
        "${product.name} 🛍️Show Now ",
      );
    } catch (e) {
      error = e.toString();
      debugPrint("UPLOAD ERROR: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}