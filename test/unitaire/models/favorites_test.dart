import 'package:flutter_test/flutter_test.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/models/favorites.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Favoris', () {
    Articles article1 = Articles(
        id: 1,
        title: 'Test article1',
        price: 10.99,
        description: 'Test description1',
        img: ['img1.jpg'],
    );

    Articles article2 = Articles(
        id: 2,
        title: 'Test article2',
        price: 12.99,
        description: 'Test description2',
        img: ['img2.jpg'],
    );

    Favorites favoris = Favorites();

    test('.add devrait ajouter à la liste des favoris', (){
      favoris.add(article1);
      favoris.add(article2);
      
      expect(favoris.products.length, 2);

      expect(favoris.products[0].id, article1.id);
      expect(favoris.products[0].price, article1.price);

      expect(favoris.products[1].title, article2.title);
      expect(favoris.products[1].description, article2.description);
      expect(favoris.products[1].img, article2.img);
    });

    test('.remove devrait supprimer de la liste des favoris', (){
      favoris.add(article1);
      favoris.add(article2);
      
      favoris.remove(article1);
      
      expect(favoris.products.length, 1);
      expect(favoris.products[0].id, article2.id);
    });

    test('.isFavorite devrait renvoyer true/false selon si l\'article est dans la liste des favoris', (){
      favoris.add(article1);

      expect(favoris.isFavorite(article1), true);
      expect(favoris.isFavorite(article2), false);
    });
  });
}