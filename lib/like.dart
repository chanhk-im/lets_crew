import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_crew/app.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:provider/provider.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  Widget _buildGridCard(BuildContext context, List<ClubModel> likes, int index) {
    final ThemeData theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 100.w, height: 100.h),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      likes[index].name, // Assuming ClubModel has a name property
                      style: TextStyle(fontSize: 17),
                      maxLines: 1,
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        // Text(
                        //   'Description: ${club.description}', // Assuming ClubModel has a description property
                        //   style: TextStyle(fontSize: 13),
                        // ),
                        TextButton(
                          onPressed: () {
                            context.read<AppState>().likeProducts(likes[index]);
                          },
                          child: Text("delete"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          // You can add additional elements based on your requirements
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          List<ClubModel> likes = appState.clubs
              .where((element) => element.likes.contains(FirebaseAuth.instance.currentUser!.uid))
              .toList();
          return ListView.builder(
            itemBuilder: (context, index) {
              return _buildGridCard(context, likes, index);
            },
            padding: const EdgeInsets.all(16.0),
            itemCount: likes.length,
          );
        },
      ),
    );
  }
}
