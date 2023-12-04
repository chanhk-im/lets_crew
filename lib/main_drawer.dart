import 'package:flutter/material.dart';
import 'package:lets_crew/app_state.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.colorScheme,
    required this.isLoggedIn,
  });

  final ColorScheme colorScheme;
  final String isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorScheme.background,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
            Consumer<AppState>(builder: (context, appState, _) {
              return ElevatedButton.icon(
                onPressed: () {
                  appState.setSelectedIndex(4);
                },
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.0,
                  color: colorScheme.onPrimary,
                ),
                label: Text(
                  isLoggedIn,
                  style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide.none,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/allClub');
              },
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 20.0,
                color: colorScheme.onPrimary,
              ),
              label: Text(
                '모든 동아리 리크루팅 알아보기',
                style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
