import 'package:flutter/material.dart';

class GeneralScreen extends StatelessWidget  {
   const GeneralScreen(
      {super.key,
      required this.screenName});
  static const routeName = '/home-screen';
  final String screenName;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor),
          child: Center(
            child: Text(
              screenName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
