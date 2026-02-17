import 'package:flutter/material.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:provider/provider.dart';
import 'package:ragersneakers/models/favorites.dart';

class Detail extends StatelessWidget {
  final Articles article;
  final int productNo;

  const Detail(this.productNo,{super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          Consumer<Favorites>(
            builder: (context, favoritesList, child) {
              final isFavorite =
                  favoritesList.isFavorite(article);

              return IconButton(
                key: Key('icon_$productNo'),
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () {
                  if (isFavorite) {
                    favoritesList.remove(article);
                  } else {
                    favoritesList.add(article);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Retiré des favories'
                            : 'Ajouté aux favories',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Icon(Icons.image, size: 30),
                        const SizedBox(height: 10),
                        Container(
                          height: 300,
                          width: double.infinity,
                          child: Image.network(
                            article.img.isNotEmpty
                                ? article.img.first
                                : "https://via.placeholder.com/150",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Card(
                      elevation: 7,
                      child: ListTile(
                        leading: const Icon(Icons.title),
                        title: Text(
                          article.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Card(
                      elevation: 7,
                      child: ListTile(
                        leading: const Icon(Icons.price_change_rounded),
                        title: const Text('Prix'),
                        subtitle: Text(
                          '${article.price}€',
                          style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Card(
                      elevation: 7,
                      child: ListTile(
                        leading: const Icon(Icons.description),
                        title: const Text('Description'),
                        subtitle: Text(
                          article.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}