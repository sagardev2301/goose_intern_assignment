import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goose_assignment/global/providers/auth.dart';
import 'package:goose_assignment/global/screens/navigation_screen.dart';
import 'package:goose_assignment/post/providers/post_provider.dart';
import 'package:goose_assignment/post/screens/post_item_screen.dart';
import 'package:goose_assignment/signin_signup/screens/email_verification_screen.dart';
import 'package:goose_assignment/signin_signup/screens/sign_in.dart';
import 'package:goose_assignment/signin_signup/screens/sign_in_options.dart';
import 'package:goose_assignment/signin_signup/screens/sign_up.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Post()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Nunito',
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color.fromARGB(255, 244, 52, 55),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, fontFamily: 'Nunito')
              .copyWith(
                displaySmall: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                labelSmall: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                labelMedium: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                bodySmall: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                bodyMedium: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                bodyLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
                titleSmall: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                titleMedium: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          SignInScreen.routeName: (ctx) => const SignInScreen(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),
          TabBarScreen.routeName: (ctx) => const TabBarScreen(),
          PostItemScreen.routeName: (ctx) => const PostItemScreen(),
        },
        home: Consumer<Auth>(
          builder: (context, value, child) {
            var authProvider = Provider.of<Auth>(context, listen: false);
            if (authProvider.isAuth && authProvider.user!.emailVerified) {
              return const TabBarScreen();
            } else {
              if (authProvider.isAuth) {
                return const EmailVerifyScreen();
              }
              return const SignInOptions();
            }
          },
        ),
      ),
    );
  }
}
