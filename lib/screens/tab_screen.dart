import 'package:flutter/material.dart';
import 'package:hackathon_app/screens/adicionar_screen.dart';
import 'package:hackathon_app/tabs/principal_tab.dart';

class TabScreen extends StatefulWidget {


  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    PrincipalTab(),
    AdicionarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Principal')),
          BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('Adicionar')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}