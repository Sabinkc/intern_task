import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavorites = prefs.getString('favorites');
    if (savedFavorites != null) {
      _favorites = List<Map<String, dynamic>>.from(json.decode(savedFavorites));
      notifyListeners();
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', json.encode(_favorites));
  }

  bool isFavorite(Map<String, dynamic> book) {
    return _favorites.any((fav) => fav['title'] == book['title']);
  }

  void toggleFavorite(Map<String, dynamic> book) {
    if (isFavorite(book)) {
      _favorites.removeWhere((fav) => fav['title'] == book['title']);
    } else {
      _favorites.add(book);
    }
    saveFavorites();
    notifyListeners();
  }
}
