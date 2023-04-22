import 'package:flutter/material.dart';

InputDecoration customInputDecoration(BuildContext context, String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle:
        TextStyle(fontSize: 16, color: Colors.grey[700], fontFamily: 'Nunito'),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.green,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}
