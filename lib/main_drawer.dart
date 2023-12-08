import 'package:flutter/material.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/user_model.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.colorScheme,
    required this.isLoggedIn,
    required this.userData,
  });

  final ColorScheme colorScheme;
  final String isLoggedIn;
  final UserModel? userData;

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
                  appState.setSelectedIndex(2);
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
                '모든 동아리 페이지 보기',
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
            userData!.role
                ? ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addClub');
                    },
                    icon: Icon(
                      Icons.add,
                      size: 20.0,
                      color: colorScheme.onPrimary,
                    ),
                    label: Text(
                      '동아리 페이지 추가하기',
                      style:
                          TextStyle(color: colorScheme.onPrimary, fontSize: 12),
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
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
