import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/like.dart';
import 'package:lets_crew/profile.dart';
import 'package:lets_crew/search.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _widgetOptions = [SearchPage(), LikePage(), HomePage(), HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.select<AppState, int>((value) => value.selectedIndex);
    
    return Scaffold(
      body: SafeArea(child: _widgetOptions[selectedIndex]),
      bottomNavigationBar: Consumer<AppState>(builder: (context, appState, _) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "like"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: "aaa"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "aaa"),
          ],
          selectedIconTheme: IconThemeData(color: Colors.black), // 선택된 아이콘 스타일
          unselectedIconTheme: IconThemeData(color: Colors.grey), // 선택되지 않은 아이콘 스타일
          currentIndex: appState.selectedIndex,
          onTap: (index) {
            appState.setSelectedIndex(index);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      }),
    );
  }
}
