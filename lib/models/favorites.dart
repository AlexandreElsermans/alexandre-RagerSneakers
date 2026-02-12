import 'package:flutter/material.dart';
import 'package:ragersneakers/models/articles.dart';

class Favorites extends ChangeNotifier {
  final List<Articles> _favoriteProducts = [];

  List<Articles> get products => _favoriteProducts;

  void add(Articles article) {
    _favoriteProducts.add(article);
    notifyListeners();
  }

  void remove(Articles article) {
    _favoriteProducts.remove(article);
    notifyListeners();
  }

  bool isFavorite(Articles article) {
    return _favoriteProducts.contains(article.id);
  }
}