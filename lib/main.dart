import 'package:flutter/material.dart';
import 'package:ragersneakers/models/shopping_cart.dart';
import 'UI/home.dart';
import 'package:provider/provider.dart';
import 'models/favorites.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation obligatoire pour Windows
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await Supabase.initialize(
    url: 'https://zetkuplmaywroqddlwvl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpldGt1cGxtYXl3cm9xZGRsd3ZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI0MDM1MjgsImV4cCI6MjA4Nzk3OTUyOH0.ykEzK7R_3tiLxvQ82NS63JyW0chtBEc66lMsBReE4TU',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Favorites()),
        ChangeNotifierProvider(create: (context) => ShoppingCart()),
      ],
      child: const MyStore(),
    )
  );
}

// Instance globale du client Supabase
final supabase = Supabase.instance.client;

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
          ? Theme.of(this).colorScheme.error
          : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
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
