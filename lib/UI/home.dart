import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // static List<Widget> pages = <Widget>[Article(), Catalogue(), Connection()];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rager Sneakers', 
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
                icon: Icon(Icons.store),
                label: Text('Catalogue'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Connexion'),
              ),
            ],
          )
        ]
      )
    );
  }
}