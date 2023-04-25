import 'package:flutter/material.dart';

import 'add_manga.dart';
import 'library.dart';
import 'other.dart';

class ScreensHolder extends StatefulWidget {
  const ScreensHolder({super.key});

  @override
  _ScreensHolderState createState() => _ScreensHolderState();
}

class _ScreensHolderState extends State<ScreensHolder> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Library(),
    AddManga(),
    Other(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('AquaReader'), backgroundColor: Colors.blueAccent),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Home',
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
