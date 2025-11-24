import 'package:flutter/material.dart';
import 'package:ragersneakers/models/articles.dart';

class Detail extends StatelessWidget {
  final Articles article;

  const Detail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${article.title} ')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.key)),
                title: const Text('Identifiant'),
                subtitle: Text('${article.id}'),
              ),
            ),
            Card(
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.title)),
                title: const Text('Titre de l\'article'),
                subtitle: Text(article.title),
              ),
            ),
            Card(
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.price_change_rounded)),
                title: const Text('Prix de l\'article '),
                subtitle: Text(article.price.toString()),
              ),
            ),

            Card(
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.description)),
                title: Text('Description de l\'article'),
                subtitle: Text(article.description),
              ),
            )
          ],
        ),
      ),
    );
  }
}