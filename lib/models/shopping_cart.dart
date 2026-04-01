import 'package:flutter/material.dart';
import 'package:ragersneakers/models/articles.dart';

class ShoppingCart extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Articles> _articleInCart = [];

  List<Articles> get articleInCart => _articleInCart;
  int get cartCount => articleInCart.length;
  double get cartPrice => calculPrice();
    
  double calculPrice() {
    double priceTotal = 0.0;
    for (Articles a in articleInCart) {
      priceTotal += a.price;
    }
    return priceTotal;
  }

  void addToCart(Articles article) {
    _articleInCart.add(article);
    notifyListeners();
  }

  void removeFromCart(Articles article) {
    _articleInCart.remove(article);
    notifyListeners();
  }

  void clearCart() {
    _articleInCart.clear();
    notifyListeners();
  }

  bool isInCart(Articles article) {
    for (Articles a in _articleInCart) {
      if (a.id == article.id) {
        return true;
      }
    } return false;
  }
}