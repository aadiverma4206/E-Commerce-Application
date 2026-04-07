import 'package:flutter/material.dart';
import '../../data/local/database_helper.dart';
import '../../data/local/favorite_model.dart';

class FavoritesViewModel extends ChangeNotifier {
  final DatabaseHelper _db;

  FavoritesViewModel({DatabaseHelper? db})
      : _db = db ?? DatabaseHelper.instance;

  List<FavoriteModel> _favorites = [];
  bool _isLoading = false;

  List<FavoriteModel> get favorites => List.unmodifiable(_favorites);
  bool get isLoading => _isLoading;

  Future<void> loadFavorites() async {
    _setLoading(true);
    try {
      _favorites = await _db.getFavorites();
    } catch (_) {
      _favorites = [];
    }
    _setLoading(false);
  }

  Future<void> addToFavorites(FavoriteModel item) async {
    await _db.insertFavorite(item);
    await loadFavorites();
  }

  Future<void> removeFromFavorites(FavoriteModel item) async {
    await _db.deleteFavorite(item.id!);
    _favorites.removeWhere((e) => e.id == item.id);
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favorites.any((e) => e.id == id);
  }

  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }
}