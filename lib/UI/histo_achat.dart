import 'package:flutter/material.dart';
import 'package:ragersneakers/models/articles.dart';
import 'package:ragersneakers/models/link_to_purchase_histo.dart';
import 'package:ragersneakers/utils/image_builder.dart';
import 'package:ragersneakers/main.dart';

class HistoAchat extends StatefulWidget {
  const HistoAchat({super.key});

  @override
  State<HistoAchat> createState() => _HistoAchatPageState();
}

class _HistoAchatPageState extends State<HistoAchat> {
  List<Articles> _achats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPurchaseHistory();
  }

  Future<void> _loadPurchaseHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        setState(() {
          _achats = [];
          _isLoading = false;
        });
        return;
      }
      
      final profileData = await supabase
          .from('profiles')
          .select('id_user')
          .eq('id', user.id)
          .maybeSingle();
      
      String? id_user;
      if (profileData != null && profileData['id_user'] != null) {
        id_user = profileData['id_user'].toString();
      } else {
        id_user = user.id;
      }
      
      final achats = await LinkToPurchaseHisto.recupHistoAchat(userId: id_user);
      setState(() {
        _achats = achats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        context.showSnackBar('Erreur lors de la récupération de l\'historique: $e', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique d\'achat'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _achats.isEmpty
              ? _buildEmptyHistory()
              : _buildHistoryContent(),
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Vous n\'avez passé aucune commande pour le moment',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryContent() {
    return ListView.builder(
      itemCount: _achats.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final purchase = _achats[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 4,
          child: ListTile(
            leading: ImageBuilder.buildCircleAvatar(
              purchase.img.isNotEmpty ? purchase.img.first : null,
              radius: 30,
            ),
            title: Text(
              purchase.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text('${purchase.price.toStringAsFixed(2)} €'),
              ],
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
        );
      },
    );
  }
}