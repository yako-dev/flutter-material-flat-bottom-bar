import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flat_bottom_bar/src/material_flat_bottom_bar_item.dart';

const double _kTabBarHeight = kBottomNavigationBarHeight;

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

class CupertinoColoredTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CupertinoColoredTabBar({
    @required this.items,
    Key key,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.border = const Border(
      top: BorderSide(
          color: _kDefaultTabBarBorderColor,
          width: 0.0,
          style: BorderStyle.solid),
    ),
  })  : assert(items != null),
        assert(
          items.length >= 2,
          "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(currentIndex != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        assert(inactiveColor != null),
        super(key: key);

  final List<MaterialFlatBottomBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final double iconSize;
  final Border border;

  @override
  Size get preferredSize => const Size.fromHeight(_kTabBarHeight);

  bool opaque(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha ==
        0xFF;
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(
              color: CupertinoDynamicColor.resolve(side.color, context));
    }

    final Border resolvedBorder = border == null || border.runtimeType != Border
        ? border
        : Border(
            top: resolveBorderSide(border.top),
            left: resolveBorderSide(border.left),
            bottom: resolveBorderSide(border.bottom),
            right: resolveBorderSide(border.right),
          );

    final Color inactive =
        CupertinoDynamicColor.resolve(inactiveColor, context);
    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: resolvedBorder,
        color: backgroundColor,
      ),
      child: SizedBox(
        height: _kTabBarHeight + bottomPadding,
        child: IconTheme.merge(
          data: IconThemeData(color: inactive, size: iconSize),
          child: DefaultTextStyle(
            style: CupertinoTheme.of(context)
                .textTheme
                .tabLabelTextStyle
                .copyWith(color: inactive),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _buildTabItems(context),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: result,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black, spreadRadius: -2, blurRadius: 2),
        ],
      ),
      child: result,
    );
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      final MaterialFlatBottomBarItem item = items[index];
      Color background = item.backgroundColor(active);
      result.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: background),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap == null
                  ? null
                  : () {
                      onTap(index);
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildSingleTabItem(item, active),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(
      MaterialFlatBottomBarItem item, bool active) {
    List<Widget> widgets = <Widget>[
      Expanded(child: Center(child: item.iconBuilder(active))),
    ];
    if (item.titleBuilder != null) widgets.add(item.titleBuilder(active));
    return widgets;
  }

  CupertinoColoredTabBar copyWith({
    Key key,
    List<MaterialFlatBottomBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    Size iconSize,
    Border border,
    int currentIndex,
    ValueChanged<int> onTap,
  }) {
    return CupertinoColoredTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }
}
