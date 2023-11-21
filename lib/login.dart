import 'package:flutter/material.dart';
import 'package:lets_crew/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = LetsCrewTheme.lightColorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Text(
              'Let\'s',
              style: LetsCrewTheme.textThemeHeading.headline1,
            ),
            Text(
              'crew',
              style: LetsCrewTheme.textThemeHeading.headline1,
            ),
            SizedBox(height: 114.0), // Optional spacing between text and button
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login with Google',
                  )
                ],
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(320.0, 60.0)),
                backgroundColor:
                    MaterialStateProperty.all(colorScheme.secondary),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '게스트로 시작하기',
                  )
                ],
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(320.0, 60.0)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
