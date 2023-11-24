import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [HomePage(), HomePage()];

  void _onItemTapped(int index) {
    // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: [BottomNavigationBarItem(icon: Icon(Icons.home), label: "hhh"), BottomNavigationBarItem(icon: Icon(Icons.home), label: "aaa")],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
