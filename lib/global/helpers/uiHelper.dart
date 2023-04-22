import 'package:flutter/material.dart';

class UiHelper{
  // to show loading spinner
  static Future<void> showSpinnerDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        heightFactor: 1,
        widthFactor: 1,
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
  // to remove loading spinner 
  static void removeSpinnerDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
  
}