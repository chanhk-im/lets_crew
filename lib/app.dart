import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_crew/club_detail.dart';
import 'package:lets_crew/all_club.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:lets_crew/theme.dart';
import 'package:lets_crew/recruiting_form.dart';

import 'club_add.dart';
import 'club_recruiting.dart';
import 'login.dart';
import 'main_page.dart';

class ScreenArguments {
  final ClubModel club;

  ScreenArguments({required this.club});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          title: 'Let\'s crew',
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(color: Colors.black),
                  iconTheme: IconThemeData(color: Colors.black))),
          initialRoute: '/login',
          routes: {
            '/login': (BuildContext context) => LoginPage(),
            '/': (BuildContext context) => MainPage(),
            '/addClub': (BuildContext context) => ClubAddPage(),
            '/allClub': (BuildContext context) => ClubAllPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/club_detail') {
              final ScreenArguments args =
                  settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                builder: (context) => ClubDetailPage(club: args.club),
              );
            }
            if (settings.name == '/add_Recruiting_form') {
              final ScreenArguments args =
                  settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                builder: (context) => RecruitingFormPage(club: args.club),
              );
            }
            if (settings.name == '/club_recruiting_form') {
              final ScreenArguments args =
                  settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                builder: (context) => ClubRecruitingPage(club: args.club),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
