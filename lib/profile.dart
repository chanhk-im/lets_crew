import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_drawer.dart';
import 'model/user_model.dart';
import 'theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository _userRepository = UserRepository();
  final colorScheme = LetsCrewTheme.lightColorScheme;
  final textScheme = Platform.isIOS ? LetsCrewTheme.textThemeIOS : LetsCrewTheme.textThemeDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
      ),
      drawer: FutureBuilder<UserModel?>(
          future: _userRepository
              .readUser(FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : null),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null) {
              return Text("로그인을 해 주시기 바랍니다.");
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
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 16.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 36.w,
              ),
              Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.secondary, width: 1.5),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Image.asset("assets/images/default_profile.png"),
              ),
              SizedBox(
                width: 20.w,
              ),
              (FirebaseAuth.instance.currentUser != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                            "${FirebaseAuth.instance.currentUser!.isAnonymous ? "익명" : FirebaseAuth.instance.currentUser!.displayName!}님"),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(FirebaseAuth.instance.currentUser!.isAnonymous
                            ? "익명"
                            : FirebaseAuth.instance.currentUser!.email!),
                        SizedBox(
                          height: 52.h,
                        ),
                      ],
                    )
                  : Text("비로그인"),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "계정",
                style: textScheme.subtitle2,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("이메일 변경"),
              SizedBox(
                height: 8.h,
              ),
              Text("비밀번호 변경"),
            ]),
          ),
          SizedBox(
            height: 12.h,
          ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "동아리",
                style: textScheme.subtitle2,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("최근 본 동아리"),
              SizedBox(
                height: 8.h,
              ),
              Text("좋아요 누른 동아리"),
              SizedBox(
                height: 8.h,
              ),
              Text("알림 받는 동아리"),
            ]),
          ),
          SizedBox(
            height: 12.h,
          ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "이용 안내",
                style: textScheme.subtitle2,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("앱 버전"),
              SizedBox(
                height: 8.h,
              ),
              Text("문의하기"),
              SizedBox(
                height: 8.h,
              ),
              Text("서비스 이용약관"),
              SizedBox(
                height: 8.h,
              ),
              Text("개인정보 처리방침"),
            ]),
          ),
          SizedBox(
            height: 12.h,
          ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "기타",
                style: textScheme.subtitle2,
              ),
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(FirebaseAuth.instance.currentUser!.isAnonymous ? "회원가입 후 이용하기" : "로그아웃")),
              SizedBox(
                height: 8.h,
              ),
              Text(FirebaseAuth.instance.currentUser!.isAnonymous ? "" : "회원 탈퇴"),
            ]),
          ),
          SizedBox(
            height: 12.h,
          ),
        ]),
      ),
    );
  }
}
