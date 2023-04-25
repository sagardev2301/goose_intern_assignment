import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goose_assignment/global/screens/navigation_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../global/providers/auth.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  static const routeName = '/email-verify-screen';

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  // late final Timer _timer;

  // @override
  // void didChangeDependencies() {
  //   var auth = Provider.of<Auth>(context);

  //   _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
  //     await auth.user!.reload();
  //     setState(() {
  //       if (auth.user!.emailVerified) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: const Text(
  //               "Email verified!",
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //             duration: const Duration(milliseconds: 1500),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //         Timer(const Duration(milliseconds: 1500), () {
  //           _timer.cancel();
  //           ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //           Navigator.of(context).pushReplacementNamed(TabBarScreen.routeName);
  //         });
  //       }
  //     });
  //   });
  //   super.didChangeDependencies();
  // }
  // @override
  // void dispose() {
  //   if (_timer.isActive) {
  //     _timer.cancel();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    var snackBar = ScaffoldMessenger.of(context);
    var themeContext = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Lottie.asset("assets/images/email_verification.json"),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    "Confirm Your email address",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We have sent a confirmation email to :",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    auth.user!.email!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Check your email and click on the\n confirmation link to continue.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if (auth.isEmailVer) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Email verified!",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        duration: const Duration(milliseconds: 1500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Future.delayed(
                      const Duration(seconds: 2),
                    );
                    // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    Navigator.of(context)
                        .pushReplacementNamed(TabBarScreen.routeName);
                  }
                },
                child: Center(
                  child: Container(
                    width: width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'Verified',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await auth.user!.sendEmailVerification();
                snackBar.showSnackBar(
                  SnackBar(
                    content: Text(
                      "Verification email sent!",
                      style: themeContext.textTheme.bodySmall,
                    ),
                    duration: const Duration(milliseconds: 2000),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    "Resend verification email",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
