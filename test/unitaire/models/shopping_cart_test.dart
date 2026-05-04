import 'package:flutter_test/flutter_test.dart';
import 'package:ragersneakers/models/shopping_cart.dart';
import 'package:ragersneakers/models/articles.dart';

void main() {
  group('Panier', () {
    Articles article1 = Articles(
      id: 1,
      title: 'Test article',
      price: 10.99,
      description: 'Test description',
      img: ['img1.jpg'],
    );

    Articles article2 = Articles(
      id: 2,
      title: 'Test article 2',
      price: 15.99,
      description: 'Test description 2',
      img: ['img2.jpg'],
    );

    ShoppingCart panier = ShoppingCart();

    test('.addToCart', (){
      panier.addToCart(article1);
      panier.addToCart(article2);

      expect(panier.cartCount, 2);

      expect(panier.articleInCart[0].id, 1);
      expect(panier.articleInCart[0].title, 'Test article');

      expect(panier.articleInCart[1].price, 15.99);
      expect(panier.articleInCart[1].description, 'Test description 2');
      expect(panier.articleInCart[1].img, ['img2.jpg']);
    });

    test('.removeFromCart', (){
      panier.addToCart(article1);
      panier.addToCart(article2);
      panier.removeFromCart(article1);

      expect(panier.cartCount, 1);

      expect(panier.articleInCart[0].id, 2);
      expect(panier.articleInCart[0].title, 'Test article 2');
    });

    test('.clearCart devrait vider la liste du panier', (){
      panier.addToCart(article1);
      panier.addToCart(article2);
      panier.clearCart();

      expect(panier.cartCount, 0);
    });

    test('.isInCart devrait vérifier que l\'article en paramètre est dans la liste du panier', (){
      panier.addToCart(article1);

      expect(panier.isInCart(article1), true);
      expect(panier.isInCart(article2), false);
    });
  });
}