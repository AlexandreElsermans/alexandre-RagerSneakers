import 'package:ragersneakers/main.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/models/database/dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LinkToPurchaseHisto {

  static Future<List<Articles>> recupHistoAchat({required String userId}) async {
    final db = await DAO.database;

    final recupAll = await db.query(
      "historique_achat",
      where: "user_id = ?",
      whereArgs: [userId],
      orderBy: "id_histo_achat DESC",
    );

    if (recupAll.isNotEmpty || userId.isNotEmpty) {
      return recupAll.map((a) => Articles.fromJson(a)).toList();
    } return [];
  }

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
    String? idUser;
    final currentUser = supabase.auth.currentUser;

    final userList  = await supabase
      .from('profiles')
      .select('id_user')
      .eq('id', currentUser!.id);

    if (userList.isNotEmpty) {
      idUser = userList.first['id_user'].toString();
    } else {
      idUser = currentUser.id;
    }

    article.id_user = idUser;

    await db.insert("historique_achat", article.toJson());
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