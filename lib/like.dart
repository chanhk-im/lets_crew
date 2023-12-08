import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_crew/app.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  final colorScheme = LetsCrewTheme.lightColorScheme;
  final textScheme = Platform.isIOS ? LetsCrewTheme.textThemeIOS : LetsCrewTheme.textThemeDefault;

  Widget _buildGridCard(BuildContext context, List<ClubModel> likes, int index) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        ClubScreenArguments args = ClubScreenArguments(club: likes[index]);
        Navigator.pushNamed(context, '/club_detail', arguments: args);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        elevation: 0,
        color: Color.fromARGB(255, 253, 234, 164),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 8.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            likes[index].name, // Assuming ClubModel has a name property
                            style: textScheme.subtitle1,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<AppState>().likeProducts(likes[index]);
                        },
                        icon: Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0.h),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23.w, bottom: 30.h, right: 20.w),
                  child: SizedBox(
                    width: 78,
                    child: Image.network(
                      likes[index].imageUrl,
                    ),
                  ),
                ),
                SizedBox(
                    width: 214.w,
                    child: Text(
                      likes[index].description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIKES'),
        leading: Consumer<AppState>(builder: (context, appState, _) {
          return IconButton(
              onPressed: () {
                appState.setSelectedIndex(0);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ));
        }),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          List<ClubModel> likes = appState.clubs
              .where((element) => element.likes.contains(FirebaseAuth.instance.currentUser!.uid))
              .toList();
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                child: _buildGridCard(context, likes, index),
              );
            },
            padding: const EdgeInsets.all(16.0),
            itemCount: likes.length,
          );
        },
      ),
    );
  }
}
