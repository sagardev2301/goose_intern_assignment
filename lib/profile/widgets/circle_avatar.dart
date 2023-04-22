import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_avatar/random_avatar.dart';

class CustomAvatar extends StatelessWidget {
  CustomAvatar({super.key});

  late Widget svgCode = RandomAvatar('hello', height: 140, width: 140);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        svgCode,
        Positioned(
          bottom: 0,
          right: 10,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: const Icon(FontAwesomeIcons.pen,
                  color: Colors.white, size: 16),
            ),
          ),
        )
      ],
    );
  }
}
