import 'package:flutter/material.dart';
import 'article.dart';
import 'favorite.dart';
import 'package:ragersneakers/UI/login.dart';
import 'package:ragersneakers/UI/profil.dart';
import 'package:ragersneakers/main.dart';

class Home extends StatefulWidget {
  static String routeName = "/";

  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = <Widget>[
      const ListArticle(),
      const FavoritesPage(),
    ];
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToProfil() {
    final user = supabase.auth.currentUser;

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileForm())
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rager Sneakers', 
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: _navigateToProfil,
            icon: const Icon(Icons.account_circle_outlined),
            label: const Text("Profil")
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.article),
                label: Text('Articles'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                label: Text('Favoris'),
              )
            ],
          ),
          Expanded(
            child: pages[_selectedIndex],
          ),
        ]
      )
    );
  }
}