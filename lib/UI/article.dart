import 'package:flutter/material.dart';
import 'favorites.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/UI/detail.dart';

class ListArticle extends StatelessWidget {
  const ListArticle({super.key});

  List<String> parseImages(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) return [raw];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    return [];
  }

  Future<List<Articles>> fetchArticles() async {
    try {
      final response = await http
        .get(Uri.parse('https://api.escuelajs.co/api/v1/products'))
        .timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200){
        final List<dynamic> jsonList = json.decode(response.body);

        return jsonList.map((json) {
          return Articles(
            id: json['id'] ?? 0,
            title: json['title'] ?? 'Future arrivée',
            price: json['price'] ?? 0.0,
            description: json['description'] ?? '',
            img: parseImages(json["images"]),
          );
        }).toList();
      } else {
        debugPrint('Status code: ${response.statusCode}');
        return _mockArticles();
      }
    } catch (e){
      debugPrint('Erreur http: $e')  ;
      return _mockArticles();
    }    
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articles>>(
      future: fetchArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child:CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        final articles = snapshot.data ?? [];

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Card(
              color: Theme.of(context).cardColor,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(article.img.isNotEmpty
                  ? article.img.first
                  : "https://via.placeholder.com/150"),
                ),
                title: Text(article.title),
                subtitle: Text(article.price.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.more),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          article.id,
                          article: article
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

List<Articles> _mockArticles() {
  return [
      Articles(
      id: 0,
      title: 'Maintenance',
      price: 0,
      description: 'Maintenance',
      img: ['https://via.placeholder.com/150'],
    ),
  ];
}