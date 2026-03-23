import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ragersneakers/main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthResponse? reponse;

  @override   
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'enregistrer")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  reponse = await supabase.auth.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                } catch (e) {
                  if (mounted) context.showSnackBar(e.toString(), isError: true);
                }
                if (reponse?.user != null) {
                  Navigator.pop(context);
                } else {
                  if (mounted) context.showSnackBar('Erreur lors de l\'enregistrement', isError: true);
                }
              },
              child: Text('S\'enregistrer'),
            )
          ],
        )
      ),
    );
  }
  @override
  void dispose () {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}