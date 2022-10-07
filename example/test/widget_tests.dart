import 'dart:core';

import 'package:example/screens/generated_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_flat_bottom_bar/material_flat_bottom_bar.dart';

void main() {
  const currentColor = Color.fromRGBO(91, 54, 183, 1);
  const blackColor = Colors.black;

  const homeIconData = Icons.home;
  const homeText = 'Home';

  const peopleIconData = Icons.people;
  const peopleText = 'Friends';

  final List<Widget> tabs = <Widget>[
    GeneratedScreen(
      name: homeText,
      inheritedScreenName: 'Profile',
      icon: homeIconData,
    ),
    GeneratedScreen(
      name: peopleText,
      inheritedScreenName: 'Friend Profile',
      icon: peopleIconData,
    ),
  ];

  testWidgets('Floating Action Button Test', (tester) async {
    bool value = false;
    Color testColor = currentColor;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              value = true;
              testColor = Colors.black;
            },
            backgroundColor: currentColor,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );

    final floatingActionButtonFinder = find.byType(FloatingActionButton);

    expect(floatingActionButtonFinder, findsOneWidget);

    final floatingActionButtonWidget =
        tester.widget<FloatingActionButton>(floatingActionButtonFinder);

    expect(floatingActionButtonWidget.backgroundColor, currentColor);

    await tester.tap(floatingActionButtonFinder);
    await tester.pump();

    expect(testColor, blackColor);
    expect(value, isTrue);
  });

  testWidgets('Material Flat Bottom Tab Bar Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MaterialFlatBottomBarScaffold(
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
                builder: (BuildContext context) => tabs[index]);
          },
          tabBar: MaterialFlatBottomTabBar(
            items: <MaterialFlatBottomTabBarItem>[
              buildItem(
                title: homeText,
                iconData: homeIconData,
                currentColor: currentColor,
              ),
              buildItem(
                title: peopleText,
                iconData: peopleIconData,
                currentColor: currentColor,
              ),
            ],
          ),
        ),
      ),
    );

    final tapBarFinder = find.byType(MaterialFlatBottomTabBar);
    expect(tapBarFinder, findsOneWidget);

    final activeTapBarIconFinder = find.descendant(
      of: tapBarFinder,
      matching: find.byIcon(homeIconData),
    );
    final activeTapBarTextFinder = find.descendant(
      of: tapBarFinder,
      matching: find.text(homeText),
    );

    final activeTapBarIconWidget = tester.widget<Icon>(activeTapBarIconFinder);
    final activeTapBarTextWidget = tester.widget<Text>(activeTapBarTextFinder);

    expect(activeTapBarIconWidget.color, currentColor);
    expect(activeTapBarTextWidget.style.color, currentColor);

    final notActiveTapBarIconFinder = find.descendant(
      of: tapBarFinder,
      matching: find.byIcon(peopleIconData),
    );
    final notActiveTapBarTextFinder = find.descendant(
      of: tapBarFinder,
      matching: find.text(peopleText),
    );

    final notActiveTapBarIconWidget =
        tester.widget<Icon>(notActiveTapBarIconFinder);
    final notActiveTapBarTextWidget =
        tester.widget<Text>(notActiveTapBarTextFinder);

    expect(notActiveTapBarIconWidget.color, blackColor);
    expect(notActiveTapBarTextWidget.style.color, blackColor);

    await tester.tap(notActiveTapBarIconFinder);
    await tester.pump();

    final tappedTapBarIconWidget =
        tester.widget<Icon>(notActiveTapBarIconFinder);

    expect(tappedTapBarIconWidget.color, currentColor);
  });
}

MaterialFlatBottomTabBarItem buildItem({
  @required String title,
  @required IconData iconData,
  @required Color currentColor,
}) {
  return MaterialFlatBottomTabBarItem(
    titleBuilder: (bool current) {
      return Text(
        title,
        style: TextStyle(
          color: current ? currentColor : Colors.black,
          fontWeight: current ? FontWeight.bold : FontWeight.w400,
          fontSize: current ? 12 : 10,
        ),
      );
    },
    iconBuilder: (bool current) {
      return Icon(
        iconData,
        color: current ? currentColor : Colors.black,
        size: 24,
      );
    },
    backgroundColor: (bool current) {
      return current ? Color.fromRGBO(224, 215, 244, 1) : Colors.white;
    },
  );
}
