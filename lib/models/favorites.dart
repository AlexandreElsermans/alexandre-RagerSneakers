import 'package:flutter/material.dart';
import 'package:ragersneakers/ViewModel/setting_view_favorites.dart';
import 'package:ragersneakers/models/articles.dart';
import 'dart:convert';

class Favorites extends ChangeNotifier {
  List<Articles> _favoriteProducts = [];
  final SettingViewFavorites _settingsView = SettingViewFavorites();

  List<Articles> get products => _favoriteProducts;

  Favorites() {
    loadSavedFavorites();
  }

  Future<void> loadSavedFavorites() async {
    final savedFavorites = await _settingsView.loadFavorites();
    _favoriteProducts = savedFavorites
      .map((jsonString) => Articles.fromJson(jsonDecode(jsonString)))
      .toList();
    notifyListeners();
  }

  Future<void> add(Articles article) async {
    _favoriteProducts.add(article);
    await saveFavorites();
    notifyListeners();
  }

  Future<void> remove(Articles article) async{
    _favoriteProducts.removeWhere((fav) => fav.id == article.id);
    await saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Articles article) {
    return _favoriteProducts.any((fav) => fav.id == article.id);
  }

  Future<void> saveFavorites() async {
    final List<String> favoritesJson = _favoriteProducts
      .map((article) => jsonEncode(article.toJson()))
      .toList();

    await _settingsView.saveFavorites(favoritesJson);
  }
}
