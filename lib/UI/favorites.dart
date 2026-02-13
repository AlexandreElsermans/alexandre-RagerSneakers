import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  static String routeName = "favorites_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favories'),
      ),
      body : Consumer<Favorites>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.products.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => FavoriteProductTile(value.products[index]),
        ),
      ),
    );
  }
}

class FavoriteProductTile extends StatelessWidget {
  const FavoriteProductTile(this.articleUIFavorites, {super.key});

  final Articles articleUIFavorites;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
                  backgroundImage: NetworkImage(articleUIFavorites.img.isNotEmpty
                  ? articleUIFavorites.img.first
                  : "https://via.placeholder.com/150"),
                ),
        title: Text(
          articleUIFavorites.title,
          key: Key('favorites_text_$articleUIFavorites'),
        ),
        trailing: IconButton(
          key: Key('remove_icon_$articleUIFavorites'),
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<Favorites>(context, listen: false).remove(articleUIFavorites);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar
              (
                content: const Text('Retiré des favories'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}