import 'package:flutter/material.dart';
import 'package:lets_crew/model/club_model.dart';

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
          // IconButton(
          //   icon: const Icon(
          //     Icons.thumb_up,
          //     semanticLabel: 'like',
          //   ),
          //   onPressed: () {
          //     likeClub(); // Call the like functionality
          //   },
          // ),
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
