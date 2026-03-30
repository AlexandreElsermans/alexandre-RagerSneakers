import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/models/database/dao.dart';

class ShoppingCarts {

  static Future<List<Articles>> listeShoppingCart() async {
    final db = await DAO.database;

    final maps = await db.query(
      "historique_achat",
      columns: ["*"],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => Articles.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<Articles> insertShoppingCart(Articles article) async {
    final db = await DAO.database;
    final id = await db.insert("historique_achat", article.toJson());
    article.id = id;
    return article;
  }

  static Future<int> deleteFromShoppingCart(int id) async {
    final db = await DAO.database;
    return await db.delete(
      "historique_achat",
      where: 'id= ?',
      whereArgs: [id],
    );
  }
}