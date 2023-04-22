import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.iconData, required this.color});
  final IconData iconData;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.grey[900],
        child: Icon(
          iconData,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
