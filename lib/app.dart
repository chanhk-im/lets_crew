import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => LoginPage(),
      },
    );
  }
}
