import 'package:flutter/material.dart';
import 'UI/home.dart';

void main() {
  runApp(const MyStore());
}

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rager Sneakers',
      theme: ThemeData(
        useMaterial3: true, // pour éviter que l'appbar soit transparent par défaut
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 152, 209),
        ),
        appBarTheme: const AppBarTheme( //applique par défaut à tous les appbar
          backgroundColor: Color.fromARGB(255, 28, 152, 209),
          foregroundColor: Colors.white,
        ),
      ),
      home: const Home(),
    );
  }
}
