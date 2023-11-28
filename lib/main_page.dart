import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lets_crew/like.dart';

import 'home.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [HomePage(), LikePage(), HomePage(), HomePage(), HomePage()];

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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "aaa"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "aaa"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "hhh"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: "aaa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "aaa"),
        ],
        selectedIconTheme: IconThemeData(color: Colors.black), // 선택된 아이콘 스타일
        unselectedIconTheme: IconThemeData(color: Colors.grey), // 선택되지 않은 아이콘 스타일
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
