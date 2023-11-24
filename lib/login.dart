import 'package:flutter/material.dart';
import 'package:lets_crew/theme.dart';

import 'app_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = LetsCrewTheme.lightColorScheme;
    final appState = AppState();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Let\'s',
              style: LetsCrewTheme.textThemeHeading.headline1,
            ),
            Text(
              'Crew',
              style: LetsCrewTheme.textThemeHeading.headline1,
            ),
            SizedBox(height: 114.0), // Optional spacing between text and button
            TextButton(
              onPressed: () async {
                final user = await appState.handleGoogleSignIn();
                if (user != null) {
                  Navigator.pushNamed(context, '/');
                }
              },
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
              onPressed: () async {
                final user = await appState.anonymousLogin();
                if (user != null) {
                  Navigator.pushNamed(context, '/');
                }
              },
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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('next'),
            ),
          ],
        ),
      ),
    );
  }
}
