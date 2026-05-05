import 'package:flutter_test/flutter_test.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/ViewModel/setting_view_favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingViewFavorites', (){
    SharedPreferences.setMockInitialValues({});
    SettingViewFavorites settingViewFavorite = SettingViewFavorites();

    Articles article1 = Articles(
      id: 1,
      title: 'Test article 1',
      price: 11.99,
      description: 'Test description 1',
      img: ['img1.jpg'],
    );

    Articles article2 = Articles(
      id: 2,
      title: 'Test article 2',
      price: 12.99,
      description: 'Test description 2',
      img: ['img2.jpg'],
    );

    List<String> favorites = [
      article1.toJson().toString(),
      article2.toJson().toString(),
    ];

    test('loadFavorites devrait charger les favoris avec sharedPreferences', () async {
      await settingViewFavorite.loadFavorites();

      expect(settingViewFavorite.favoriteProducts, isA<List<String>>());
      expect(settingViewFavorite.favoriteProducts.length, 0);
      expect(settingViewFavorite.isLoading, false);
    });

    test('saveFavorites devrait sauvegarder les favoris grâce à sharedPreferences', () async {
      await settingViewFavorite.saveFavorites(favorites);

      expect(settingViewFavorite.favoriteProducts, isA<List<String>>());
      expect(settingViewFavorite.favoriteProducts.length, 2);
      expect(settingViewFavorite.favoriteProducts[0], article1.toJson().toString());
      expect(settingViewFavorite.favoriteProducts[1], article2.toJson().toString());

      final loadedList = await settingViewFavorite.loadFavorites();
      expect(loadedList[0], article1.toJson().toString());
      expect(loadedList.length, settingViewFavorite.favoriteProducts.length);
    });

    test('LoadFavorites ne devrait rien renvoyer si rien n\'est sauvegardé', () async {
      SettingViewFavorites emptySettingViewFavorite = SettingViewFavorites();
      
      final loadedList = await emptySettingViewFavorite.loadFavorites();

      expect(loadedList, isEmpty);
      expect(emptySettingViewFavorite.favoriteProducts, isEmpty);
    });
  });
}