import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_crew/app.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'theme.dart';

class ClubDetailPage extends StatefulWidget {
  final ClubModel club;

  ClubDetailPage({required this.club});

  @override
  _ClubDetailPageState createState() => _ClubDetailPageState(club: club);
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  ClubModel club;
  final colorScheme = LetsCrewTheme.lightColorScheme;
  _ClubDetailPageState({required this.club});

  @override
  Widget build(BuildContext context) {
    String titleName = club.name;

    return Scaffold(
      floatingActionButton: Consumer<AppState>(builder: (context, appState, _) {
        return Stack(
          children: <Widget>[
            if (appState.currentUser != null && appState.currentUser!.role)
              Align(
                alignment: Alignment(
                    Alignment.bottomRight.x, Alignment.bottomRight.y - 0.4),
                child: FloatingActionButton(
                    heroTag: "admin",
                    onPressed: () {
                      ClubScreenArguments args =
                          ClubScreenArguments(club: club);
                      Navigator.pushNamed(context, '/submission_list',
                          arguments: args);
                    },
                    backgroundColor: colorScheme.secondary,
                    child: Icon(Icons.list)),
              ),
            if (appState.currentUser != null && appState.currentUser!.role)
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    heroTag: "add",
                    onPressed: () {
                      ClubScreenArguments args =
                          ClubScreenArguments(club: club);
                      Navigator.pushNamed(context, '/add_Recruiting_form',
                          arguments: args);
                    },
                    backgroundColor: colorScheme.secondary,
                    child: Icon(Icons.add_chart)),
              ),
            Align(
              alignment: Alignment(
                  Alignment.bottomRight.x,
                  Alignment.bottomRight.y -
                      ((appState.currentUser != null &&
                              appState.currentUser!.role)
                          ? 0.2
                          : 0)),
              child: FloatingActionButton(
                heroTag: "show",
                onPressed: () {
                  ClubScreenArguments args = ClubScreenArguments(club: club);
                  Navigator.pushNamed(context, '/club_recruiting_form',
                      arguments: args);
                },
                backgroundColor: colorScheme.secondary,
                child: Icon(Icons.perm_contact_cal_outlined),
              ),
            )
          ],
        );
      }),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(titleName),
        actions: <Widget>[
          if (FirebaseAuth.instance.currentUser != null)
            Consumer<AppState>(builder: (context, appState, _) {
              return IconButton(
                icon: Icon(
                  (club.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Icons.favorite
                      : Icons.favorite_border),
                  semanticLabel: 'like',
                ),
                onPressed: () async {
                  await appState.likeProducts(club);
                },
              );
            }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1000.w,
                decoration: ShapeDecoration(
                  color: Color(0x40FFE68F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0)),
                          child: Image.network(club.imageUrl),
                        ),
                        Divider(),
                        Text(club.name),
                        Text(club.description),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.question_answer_outlined),
                            Icon(Icons.calendar_month_outlined),
                            Icon(Icons.person_search_outlined)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 80.w,
                              child: Text(
                                club.aboutClub,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 80.w,
                              child: Text(
                                club.compulsory,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 80.w,
                              child: Text(
                                club.forwho,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ]),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 1000.w,
                decoration: ShapeDecoration(
                  color: Color(0x40FFE68F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          '${club.name}는 이런 활동을 해요!',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Divider(),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.stars),
                              title: Text(club.activity[0]),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.stars),
                              title: Text(club.activity[1]),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.stars),
                              title: Text(club.activity[2]),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
