import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_flat_bottom_bar/material_flat_bottom_bar.dart';

void main() {
  group('Material Flat Bottom Bar tests', () {
    const currentColor = Color.fromRGBO(91, 54, 183, 1);

    const homeIconData = Icons.home;
    const homeText = 'Home';

    const peopleIconData = Icons.people;
    const peopleText = 'Friends';

    final List<Widget> tabs = <Widget>[Container(), Container()];

    bool isPressed = false;
    final materialFlatBottomBarScaffold = MaterialFlatBottomBarScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) => tabs[index]);
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isPressed = true;
        },
        backgroundColor: currentColor,
        child: Icon(Icons.add),
      ),
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
    );

    testWidgets('FloatingActionButton should render correctly', (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('FloatingActionButton content should match', (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      final floatingActionButtonFinder =
          find.widgetWithIcon(FloatingActionButton, Icons.add);
      final floatingActionButton =
          tester.widget<FloatingActionButton>(floatingActionButtonFinder);

      expect(floatingActionButtonFinder, findsOneWidget);
      expect(floatingActionButton.backgroundColor, currentColor);
    });

    testWidgets('FloatingActionButton onTap is called', (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      await tester.tap(find.byType(FloatingActionButton));
      expect(isPressed, true);
    });

    testWidgets('MaterialFlatBottomTabBar should render correctly',
        (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      expect(find.byType(MaterialFlatBottomTabBar), findsOneWidget);
    });

    testWidgets('MaterialFlatBottomTabBar content should match',
        (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      expect(find.text(homeText), findsOneWidget);
      expect(find.byIcon(homeIconData), findsOneWidget);

      expect(find.text(peopleText), findsOneWidget);
      expect(find.byIcon(peopleIconData), findsOneWidget);
    });

    testWidgets('MaterialFlatBottomTabBar item onTap is called',
        (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));
      final peopleIconFinder = find.byIcon(peopleIconData);

      await tester.tap(peopleIconFinder);
      await tester.pump();

      final iconWidget = tester.widget<Icon>(peopleIconFinder);
      expect(iconWidget.color, currentColor);
    });

    testWidgets('MarkedBottomNavigation item selected style should match',
        (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      final selectedIconFinder = find.byIcon(homeIconData);
      expect(selectedIconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(selectedIconFinder);

      final selectedTextFinder = find.text(homeText);

      final textWidget = tester.widget<Text>(selectedTextFinder);

      expect(iconWidget.color, currentColor);
      expect(textWidget.style.color, currentColor);
      expect(textWidget.style.fontWeight, FontWeight.bold);
      expect(textWidget.style.fontSize, 12);
    });

    testWidgets('MarkedBottomNavigation item unselected style should match',
        (tester) async {
      await tester
          .pumpWidget(_wrapWithMaterialApp(materialFlatBottomBarScaffold));

      final unselectedIconFinder = find.byIcon(peopleIconData);
      expect(unselectedIconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(unselectedIconFinder);

      final unselectedTextFinder = find.text(peopleText);

      final textWidget = tester.widget<Text>(unselectedTextFinder);

      expect(iconWidget.color, Colors.black);
      expect(textWidget.style.color, Colors.black);
      expect(textWidget.style.fontWeight, FontWeight.w400);
      expect(textWidget.style.fontSize, 10);
    });
  });
}

Widget _wrapWithMaterialApp(Widget testWidget) {
  return MaterialApp(home: testWidget);
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
