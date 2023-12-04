import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'model/user_model.dart';
import 'theme.dart';
import 'main_drawer.dart';

class ClubAllPage extends StatefulWidget {
  ClubAllPage({Key? key}) : super(key: key);
  _ClubAllPageState createState() => _ClubAllPageState();
}

class _ClubAllPageState extends State<ClubAllPage> {
  final UserRepository _userRepository = UserRepository();
  final colorScheme = LetsCrewTheme.lightColorScheme;
  Future<List<Widget>> _buildGridCards(BuildContext context) async {
    List<ClubModel> clubs =
        context.select<AppState, List<ClubModel>>((value) => value.clubs);

    if (clubs.isEmpty) {
      return const <Widget>[];
    }

    final ThemeData theme = Theme.of(context);

    return clubs.map((club) {
      return GestureDetector(
        onTap: () {
          // Navigate to the club detail page when the card is tapped
          ScreenArguments args = ScreenArguments(club: club);
          Navigator.pushNamed(context, '/club_detail', arguments: args);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 18 / 11,
                    child: Container(
                      width: 100,
                      child: Image.network(
                        club.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            club.name,
                            style: LetsCrewTheme.textThemeHeading.headline2,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // You can add additional elements based on your requirements
            ],
          ),
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
        });
  }
}
