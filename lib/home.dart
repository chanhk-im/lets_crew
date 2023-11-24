import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'model/user_model.dart';
import 'theme.dart';

class HomePage extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();
  final colorScheme = LetsCrewTheme.lightColorScheme;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future:
            _userRepository.readUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            UserModel? userData = snapshot.data;
            User? user = FirebaseAuth.instance.currentUser;
            String isLoggedIn = "회원가입 후 이용하기";
            if (userData?.name != null) {
              isLoggedIn = "프로필 확인하기";
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('HOME'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/addClub');
                      },
                      icon: Icon(
                        Icons.add,
                      ))
                ],
              ),
              drawer: Drawer(
                backgroundColor: colorScheme.background,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 120),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.account_circle_outlined,
                          size: 20.0,
                          color: colorScheme.onPrimary,
                        ),
                        label: Text(
                          isLoggedIn,
                          style: TextStyle(
                              color: colorScheme.onPrimary, fontSize: 12),
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
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          size: 20.0,
                          color: colorScheme.onPrimary,
                        ),
                        label: Text(
                          '모든 동아리 리크루팅 알아보기',
                          style: TextStyle(
                              color: colorScheme.onPrimary, fontSize: 12),
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
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          }
          ;
        });
  }
}
