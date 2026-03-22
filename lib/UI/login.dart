import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ragersneakers/UI/profil.dart';
import 'package:ragersneakers/UI/registration.dart';
import 'package:ragersneakers/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthResponse? reponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône de profil
            const Icon(
              Icons.person_outline,
              size: 80,
              color: Color.fromARGB(255, 28, 152, 209),
            ),
            const SizedBox(height: 32),
            
            // Champ Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Champ Mot de passe
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            
            // Bouton de connexion
            ElevatedButton(
              onPressed: () async {
                try {
                  reponse = await supabase.auth.signInWithPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  
                  if (reponse?.user != null && mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileForm()),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    context.showSnackBar(
                      "Erreur de connexion: ${e.toString()}", 
                      isError: true
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Se connecter"),
            ),
            const SizedBox(height: 12),
            
            // Bouton d'inscription
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                );
              },
              child: const Text(
                'Pas encore de compte ? S\'inscrire',
                style: TextStyle(
                  color: Color.fromARGB(255, 28, 152, 209),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}