import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:goose_assignment/profile/widgets/circle_avatar.dart';
import 'package:goose_assignment/profile/widgets/profile_option_extra.dart';
import 'package:goose_assignment/profile/widgets/profile_screen_option.dart';
import '../../global/providers/auth.dart';


class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({ Key? key,}) : super(key: key);

  static const routeName = '/main-profile-screen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomAvatar(),
          ProfileOption(
            title: 'Personal Information',
            iconColor: const Color.fromARGB(255, 91, 185, 96),
            iconData: FontAwesomeIcons.solidUser,
            showArrow: true,
            onPressed: () {},
          ),
          ProfileOption(
            title: 'Change Password',
            iconColor: const Color.fromARGB(255, 160, 249, 164),
            iconData: FontAwesomeIcons.shieldHalved,
            showArrow: true,
            onPressed: () {},
          ),
          const ProfileOptionExtra(
              title: 'Push Notifications',
              iconData: FontAwesomeIcons.solidBell,
              iconColor: Color.fromARGB(218, 238, 212, 42),
              description: 'Recieve alerts for bid activity'),
          const ProfileOptionExtra(
              title: 'Subscribe to Emails',
              iconData: FontAwesomeIcons.solidMessage,
              iconColor: Color.fromARGB(218, 65, 135, 246),
              description: 'Receive marketing emails'),
          ProfileOption(
            title: 'Language',
            iconColor: const Color.fromARGB(218, 229, 117, 117),
            iconData: FontAwesomeIcons.solidSquareMinus,
            currentLanguageChoosed: 'English (US)',
            showArrow: true,
            onPressed: () {},
          ),
          ProfileOption(
            title: 'Logout',
            iconColor: const Color.fromARGB(255, 239, 92, 69),
            // ignore: deprecated_member_use
            iconData: FontAwesomeIcons.signOutAlt,
            showArrow: false,
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
