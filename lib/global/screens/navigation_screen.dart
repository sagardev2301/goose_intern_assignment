import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../post/screens/post_item_screen.dart';
import '../../profile/screens/main_profile_screen.dart';
import 'general_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});
  static const routeName = '/tab-screen';
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int previousIndex;

  List<String> screenNames = [
    'HomeScreen',
    'ItemsScreen',
    'PostItemScreen',
    'ServicesScreen',
    'ProfileSettings'
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    previousIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenNames[tabController.index],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: IconButton(
          onPressed: () {
            setState(() {
              tabController.index = previousIndex;
            });
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: IndexedStack(
        alignment: Alignment.center,
        index: tabController.index,
        children: [
          GeneralScreen(
            screenName: screenNames[tabController.index],
          ),
          GeneralScreen(
            screenName: screenNames[tabController.index],
          ),
          GeneralScreen(
            screenName: screenNames[tabController.index],
          ),
          GeneralScreen(
            screenName: screenNames[tabController.index],
          ),
          MainProfileScreen(

          ),
        ],
      ),
      bottomNavigationBar: BottomBarFloating(
        bottom: 15,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        backgroundColor: Colors.grey[800]!,
        color: Colors.white,
        colorSelected: Theme.of(context).primaryColor,
        iconSize: 20,
        titleStyle: Theme.of(context).textTheme.labelMedium,
        indexSelected: tabController.index,
        animated: false,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, PostItemScreen.routeName);
            setState(() {
              tabController.index = 0;
            });
          } else {
            setState(() {
              previousIndex = tabController.index;
              tabController.index = index;
            });
          }
        },
        items: const [
          TabItem(title: "Home", icon: FontAwesomeIcons.houseChimney),
          TabItem(title: "Items", icon: FontAwesomeIcons.boxOpen),
          TabItem(title: "", icon: FontAwesomeIcons.circlePlus),
          TabItem(title: "Services", icon: FontAwesomeIcons.wandSparkles),
          TabItem(title: "Profile", icon: FontAwesomeIcons.solidUser),
        ],
      ),
    );
  }
}
