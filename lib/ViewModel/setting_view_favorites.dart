import 'package:flutter/foundation.dart';
import 'package:ragersneakers/repository/settings_repo_favorites.dart';

class SettingViewFavorites extends ChangeNotifier {
  final SettingsRepoFavorites _repo = SettingsRepoFavorites();

  List<String> _favoriteProducts = [];
  bool _isLoading = false;

  List<String> get favoriteProducts => _favoriteProducts;
  bool get isLoading => _isLoading;

  SettingViewFavorites() {
    loadFavorites();
  }

  Future<List<String>> loadFavorites() async {
    try{
      final value = await _repo.getFavorites();
      _favoriteProducts = value;
    } catch (e) {
      debugPrint("Erreur dans le chargement des favoris : $e");
      _favoriteProducts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _favoriteProducts;
  }

  Future<void> saveFavorites(List<String> favorites) async {
    try {
      await _repo.saveFavorites(favorites);
      _favoriteProducts = favorites;
      notifyListeners();
    } catch (e) {
      debugPrint("Erreur lors de la sauvegarde des favoris : $e");
    }
  }
}