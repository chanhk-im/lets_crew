import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_crew/club_detail.dart';
import 'package:lets_crew/home.dart';
import 'package:lets_crew/model/club_model.dart';
import 'package:lets_crew/recruiting_form.dart';
import 'club_add.dart';
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
          initialRoute: '/login',
          routes: {
            '/login': (BuildContext context) => LoginPage(),
            '/': (BuildContext context) => MainPage(),
            '/addClub': (BuildContext context) => ClubAddPage(),
            '/recruiting_form': (BuildContext context) => RecruitingFormPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/club_detail') {
              final ScreenArguments args = settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                builder: (context) => ClubDetailPage(club: args.club),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
