import 'package:flutter/material.dart';
import '../../data/local/database_helper.dart';
import '../../data/local/favorite_model.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<FavoriteModel> favorites = [];

  Future<void> loadFavorites() async {
    favorites = await DatabaseHelper.instance.getFavorites();
    notifyListeners();
  }
}