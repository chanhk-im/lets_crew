import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lets_crew/model/club_model.dart';
import 'app.dart';
import 'model/user_model.dart';
import 'theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserRepository _userRepository = UserRepository();
  final ClubRepository _clubRepository = ClubRepository();
  final colorScheme = LetsCrewTheme.lightColorScheme;
  Future<List<Widget>> _buildGridCards(BuildContext context) async {
    List<ClubModel> clubs = await _clubRepository.readAllClubs();

    if (clubs.isEmpty) {
      return const <Widget>[];
    }

    final ThemeData theme = Theme.of(context);

    return clubs.map((club) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                    aspectRatio: 18 / 11,
                    child: Container(
                      width: 100,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          club.name, // Assuming ClubModel has a name property
                          style: TextStyle(fontSize: 17),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            // Text(
                            //   'Description: ${club.description}', // Assuming ClubModel has a description property
                            //   style: TextStyle(fontSize: 13),
                            // ),
                            TextButton(
                              onPressed: () {
                                ScreenArguments args =
                                    ScreenArguments(club: club);
                                Navigator.pushNamed(context, '/club_detail',
                                    arguments: args);
                              },
                              child: Text("more"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // You can add additional elements based on your requirements
          ],
        ),
      );
    }).toList();
  }

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
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/recruiting_form');
                        },
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          size: 20.0,
                          color: colorScheme.onPrimary,
                        ),
                        label: Text(
                          '리크루팅 추가',
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
                    ],
                  ),
                ),
              ),
              body: FutureBuilder<List<Widget>>(
                future: _buildGridCards(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(16.0),
                      childAspectRatio: 8.0 / 9.0,
                      children: snapshot.data!,
                    );
                  }
                },
              ),
            );
          }
          ;
        });
  }
}
