import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/models/shopping_cart.dart';
import 'package:ragersneakers/models/link_to_purchase_histo.dart';
import 'package:ragersneakers/utils/image_builder.dart';
import 'package:ragersneakers/main.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Panier'),
      ),
      body: Consumer<ShoppingCart>(
        builder: (context, cart, child) {
          if (cart.articleInCart.isEmpty) {
            return _buildEmptyCart(context);
          }
          return _buildCartContent(context, cart);
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Votre panier est vide',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Retournez voir notre sélection d\'articles !',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, ShoppingCart cart) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.cartCount,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              final article = cart.articleInCart[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: ImageBuilder.buildCircleAvatar(
                    article.img.isNotEmpty ? article.img.first : null,
                    radius: 30,
                  ),
                  title: Text(
                    article.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${article.price.toStringAsFixed(2)} €'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => cart.removeFromCart(article),
                  ),
                ),
              );
            },
          ),
        ),
        _buildCartSummary(context, cart),
      ],
    );
  }

  Widget _buildCartSummary(BuildContext context, ShoppingCart cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${cart.cartPrice.toStringAsFixed(2)} €',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _validateOrder(context, cart),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Passer commande'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _validateOrder(BuildContext context, ShoppingCart cart) async {
    if (cart.articleInCart.isEmpty) return;

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        context.showSnackBar('Veuillez vous connecter pour valider votre commande', isError: true);
        return;
      }
      
      final articleToSave = List<Articles>.from(cart.articleInCart);
    
      for (Articles a in articleToSave) {
        await LinkToPurchaseHisto.insertShoppingCart(a);
      }
      cart.clearCart();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Commande validée avec succès !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      
    } catch (e) {
      context.showSnackBar('Erreur lors de la validation: $e', isError: true);  
    }
  }
}