import 'package:flutter/material.dart';
import 'UI/home.dart';
import 'package:provider/provider.dart';
import 'models/favorites.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Favorites(),
      child: const MyStore(),
      )
  );
}

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rager Sneakers',
      debugShowCheckedModeBanner: false,
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
