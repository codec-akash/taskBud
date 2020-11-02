import 'package:flutter/material.dart';

import 'package:TaskApp/global.dart';
import 'package:TaskApp/screens/task_screen.dart';
import 'package:TaskApp/screens/home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Home',
      },
      {
        'page': TaskScreen(),
        'title': 'Task',
      },
      {
        'page': HomeScreen(),
        'title': 'History',
      },
      {
        'page': HomeScreen(),
        'title': 'Profile',
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Bud',
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).accentColor,
        ),
        child: BottomNavigationBar(
          onTap: _selectedPage,
          elevation: 0.0,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.blue,
          unselectedItemColor: grey,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
