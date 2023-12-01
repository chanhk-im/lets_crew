import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_crew/app.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:provider/provider.dart';

class ClubDetailPage extends StatefulWidget {
  final ClubModel club;

  ClubDetailPage({required this.club});

  @override
  _ClubDetailPageState createState() => _ClubDetailPageState(club: club);
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  ClubModel club;

  _ClubDetailPageState({required this.club});

  @override
  Widget build(BuildContext context) {
    String titleName = club.name;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScreenArguments args = ScreenArguments(club: club);
          Navigator.pushNamed(context, '/add_Recruiting_form', arguments: args);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        title: Text(titleName),
        actions: <Widget>[
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
                // if (club.likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
                //   print(club.likes);
                //   setState(() {
                //     club.likes.add(FirebaseAuth.instance.currentUser!.uid);
                //   });
                // } else {
                //   print(club.likes);
                //   setState(() {
                //     club.likes.add(FirebaseAuth.instance.currentUser!.uid);
                //   });
                // }
              },
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  club.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
            Text('Category: ${club.category}'),
            Text('Description: ${club.description}'),
            Text('About Club: ${club.aboutClub}'),
            Text('Compulsory: ${club.compulsory}'),
            Text('For Who: ${club.forwho}'),
            Text('Activity: ${club.activity}'),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
