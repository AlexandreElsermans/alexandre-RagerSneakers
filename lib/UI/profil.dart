import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'avatar.dart';
import 'histo_achat.dart';


class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  var _loading = true;
  final _usernameController = TextEditingController();
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadProfile());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
        .from('profiles')
        .select()
        .match({'id': userId})
        .maybeSingle();
      setState(() {
        if (data != null) {
          _usernameController.text = data['username'] ?? '';
          _avatarUrl = (data['avatar_url'] ?? '') as String;
        }
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
          scaffoldMessenger.showSnackBar(const SnackBar(
            content: Text('Erreur détectée lors du chargement du profil'),
            backgroundColor: Colors.red,
          ));
      }
    }
  }

  Future<void> _saveProfile() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    setState(() => _loading = true);
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').upsert({
        'id': userId,
        'username': _usernameController.text,
        'updated_at': DateTime.now().toIso8601String(),
      });
    
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Profil sauvegardé avec succès')),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text('Erreur détectée lors de la sauvegarde'),
        backgroundColor: Colors.red,
      ));
    }
    setState(() => _loading = false);
  }

  Future<void> _onUpload(String imageUrl) async {
  try {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('profiles').upsert({
      'id': userId,
      'avatar_url': imageUrl,
    });
    
    if (mounted) context.showSnackBar('Votre avatar a été mis à jour');
  } on PostgrestException catch (error) {
    if (mounted) context.showSnackBar(error.message, isError: true);
  } catch (error) {
    if (mounted) {
      context.showSnackBar('Erreur détectée', isError: true);
    }
  }
  
  if (!mounted) return;
  setState(() => _avatarUrl = imageUrl);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil')
      ),
      body: _loading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20
            ),
            children: [
              Avatar(
                imageUrl: _avatarUrl,
                onUpload: _onUpload
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  label: Text('Nom d\'utilisateur')
                ),
              ),
              
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Sauvegarder')
              ),

              const SizedBox(height: 16),

              OutlinedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoAchat(),
                    ),
                  ),
                },
                child: const Text('Historique de vos achats'),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  supabase.auth.signOut();
                  Navigator.pop(context);
                },
                child: const Text('Se déconnecter'),
              ),
            ],
          ),
    );
  }
}