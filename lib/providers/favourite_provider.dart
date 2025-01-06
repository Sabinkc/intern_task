

import 'package:flutter/material.dart';
import 'package:intern_app/database/database_helper.dart';


class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  // Load favorites from SQLite
  Future<void> loadFavorites() async {
    _favorites = await DatabaseHelper.instance.fetchFavorites();
    notifyListeners();
  }

  // Add or remove from favorites
  Future<void> toggleFavorite(Map<String, dynamic> book) async {
    final isFavorite = _favorites.any((fav) => fav['title'] == book['title']);
    
    if (isFavorite) {
      await DatabaseHelper.instance.deleteFavorite(book['title']);
      _favorites.removeWhere((fav) => fav['title'] == book['title']);
    } else {
      await DatabaseHelper.instance.insertFavorite(book);
      _favorites.add(book);
    }

    notifyListeners();
  }

  // Check if the book is a favorite
  bool isFavorite(Map<String, dynamic> book) {
    return _favorites.any((fav) => fav['title'] == book['title']);
  }
}
