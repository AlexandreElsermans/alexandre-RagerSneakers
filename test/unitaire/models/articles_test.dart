import 'package:ragersneakers/models/articles.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Articles', () {
    Articles article = Articles(
      id: 1,
      title: 'Test article',
      price: 10.99,
      description: 'Test description',
      img: ['img1.jpg'],
    );

    test('Test fromJson qui devrait renvoyer un fichier objet Articles', (){
      Articles.fromJson(article.toJson());

      expect(article.id, 1);
      expect(article.title, 'Test article');
      expect(article.price, 10.99);
      expect(article.description, 'Test description');
      expect(article.img, ['img1.jpg']);
    });

    test('Test toJson qui devrait renvoyer un objet Json', (){
      final articleTest = Articles(
        id: 1,
        title: 'Test article',
        price: 10.99,
        description: 'Test description',
        img: ['img1.jpg']
      );

      final articleJson = articleTest.toJson();

      expect(articleJson["article_id"], equals(1));
      expect(articleJson["title"], 'Test article');
      expect(articleJson["price"], equals(10.99));
      expect(articleJson["description"], 'Test description');
      expect(articleJson["img"], ('img1.jpg'));
    });
  });
}