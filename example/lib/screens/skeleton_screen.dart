import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_flat_bottom_bar/material_flat_bottom_bar.dart';

import 'generated_screen.dart';

class SkeletonScreen extends StatefulWidget {
  @override
  _SkeletonScreenState createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  final List<Widget> tabs = <Widget>[
    GeneratedScreen(
      name: 'Home',
      inheritedScreenName: 'Profile',
      icon: Icons.supervised_user_circle,
    ),
    GeneratedScreen(
      name: 'Friends',
      inheritedScreenName: 'Friend Profile',
      icon: Icons.people,
    ),
    GeneratedScreen(
      name: 'Settings',
      inheritedScreenName: 'Theme settings',
      icon: Icons.settings,
    ),
    GeneratedScreen(
      name: 'More',
      inheritedScreenName: 'Terms',
      icon: Icons.more_horiz,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialFlatBottomBarScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) => tabs[index]);
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
      tabBar: MaterialFlatBottomTabBar(
        items: <MaterialFlatBottomTabBarItem>[
          buildItem(title: 'Home', iconData: Icons.home),
          buildItem(title: 'Friends', iconData: Icons.people),
          buildItem(title: 'Settings', iconData: Icons.settings),
          buildItem(title: 'More', iconData: Icons.more_horiz),
        ],
      ),
    );
  }

  MaterialFlatBottomTabBarItem buildItem({
    @required String title,
    @required IconData iconData,
  }) {
    return MaterialFlatBottomTabBarItem(
      titleBuilder: (bool current) {
        return Text(
          title,
          style: TextStyle(
            color: current ? Color.fromRGBO(91, 54, 183, 1) : Colors.black,
            fontWeight: current ? FontWeight.bold : FontWeight.w400,
            fontSize: current ? 12 : 10,
          ),
        );
      },
      iconBuilder: (bool current) {
        return Icon(
          iconData,
          color: current ? Color.fromRGBO(91, 54, 183, 1) : Colors.black,
          size: 24,
        );
      },
      backgroundColor: (bool current) {
        return current ? Color.fromRGBO(224, 215, 244, 1) : Colors.white;
      },
    );
  }
}
