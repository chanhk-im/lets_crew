import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_crew/home.dart';

import 'login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          title: 'Shrine',
          initialRoute: '/login',
          routes: {
            '/login': (BuildContext context) => LoginPage(),
            '/': (BuildContext context) => HomePage(),
          },
        );
      },
    );
  }
}
