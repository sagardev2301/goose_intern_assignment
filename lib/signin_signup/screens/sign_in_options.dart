import 'package:flutter/material.dart';
import 'package:goose_assignment/signin_signup/screens/sign_in.dart';
import 'package:goose_assignment/signin_signup/screens/sign_up.dart';
import 'package:goose_assignment/signin_signup/widgets/log_in_button.dart';
import 'package:lottie/lottie.dart';

class SignInOptions extends StatelessWidget {
  const SignInOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 60, 0, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: 240,
                width: 240,
                child: Lottie.asset('assets/images/sign_in.json')),
            Text(
              'Let\'s get you in',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Buttons for login using different platforms
            LogInChip(
              platform: 'Google',
              onPressed: () {},
            ),
            LogInChip(
              platform: 'Facebook',
              onPressed: () {},
            ),
            //Divider
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey[800],
                    height: 2,
                    width: width * 0.4,
                  ),
                  Text(
                    '   or    ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Container(
                    color: Colors.grey[800],
                    height: 2,
                    width: width * 0.4,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              },
              child: Container(
                width: width * 0.8,
                height: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    'Sign in with Email',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have account?',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                  child: Text(
                    'SignUp',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
