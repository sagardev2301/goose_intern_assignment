import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goose_assignment/profile/widgets/custom_icon.dart';

class ProfileOption extends StatelessWidget {
  const ProfileOption(
      {super.key,
      required this.title,
      required this.iconData,
      required this.iconColor,
      required this.showArrow,
      this.currentLanguageChoosed,
      this.onPressed});
  final String title;
  final IconData iconData;
  final Color iconColor;
  final bool showArrow;
  final String? currentLanguageChoosed;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: height * 0.098,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomIcon(iconData: iconData, color: iconColor),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              if (currentLanguageChoosed != null)
                Text(
                  currentLanguageChoosed!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (showArrow)
                Icon(
                  CupertinoIcons.chevron_forward,
                  size: 30,
                  color: Colors.grey[600],
                )
            ],
          ),
        ),
      ),
    );
  }
}
