import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'main_drawer.dart';
import 'model/club_model.dart';
import 'model/user_model.dart';
import 'theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final UserRepository _userRepository = UserRepository();
  final colorScheme = LetsCrewTheme.lightColorScheme;
  final textScheme = Platform.isIOS ? LetsCrewTheme.textThemeIOS : LetsCrewTheme.textThemeDefault;
  final searchTextController = TextEditingController();
  List<ClubModel> searchResult = [];

  @override
  Widget build(BuildContext context) {
    List<ClubModel> clubs = context.select<AppState, List<ClubModel>>((value) => value.clubs);
    searchTextController.addListener(() {
      if (searchTextController.text == "") {
        setState(() {
          searchResult = [];
        });
      } else {
        setState(() {
          searchResult = clubs.where(
            (element) {
              return element.name.toLowerCase().contains(searchTextController.text.toLowerCase());
            },
          ).toList();
        });
      }
    });

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
        drawer: FutureBuilder<UserModel?>(
            future: _userRepository.readUser(FirebaseAuth.instance.currentUser!.uid),
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
                return MainDrawer(colorScheme: colorScheme, isLoggedIn: isLoggedIn);
              }
            }),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 14.h),
              child: TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.surface,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.surface,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    hintText: "검색할 동아리를 입력하세요"),
              ),
            ),
            Container(
              height: 20.h + (24.h + 12.w) * searchResult.length,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(40.w, 12.h, 40.w, 12.h),
                    child: Container(child: Text(searchResult[index].name, style: textScheme.bodyText2)),
                  );
                },
                itemCount: searchResult.length,
                padding: EdgeInsets.only(bottom: 20.h),
              ),
            ),
            const Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ],
        ));
  }
}
