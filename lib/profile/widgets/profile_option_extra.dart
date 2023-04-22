import 'package:flutter/material.dart';
import 'package:goose_assignment/profile/widgets/custom_icon.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ProfileOptionExtra extends StatefulWidget {
  const ProfileOptionExtra(
      {super.key,
      required this.title,
      required this.iconData,
      required this.iconColor,
      required this.description});
  final String title;
  final String description;
  final IconData iconData;
  final Color iconColor;

  @override
  State<ProfileOptionExtra> createState() => _ProfileOptionExtraState();
}

class _ProfileOptionExtraState extends State<ProfileOptionExtra> {
  late bool swithVal = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.095,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIcon(iconData: widget.iconData, color: widget.iconColor),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            const Spacer(),
            FlutterSwitch(
                height: 28,
                width: 56,
                padding: 2,
                activeColor: Theme.of(context).primaryColor,
                value: swithVal,
                onToggle: (val) => setState(() {
                      swithVal = val;
                    }))
          ],
        ),
      ),
    );
  }
}
