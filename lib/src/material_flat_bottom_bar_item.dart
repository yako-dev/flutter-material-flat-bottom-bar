import 'package:flutter/material.dart';

class MaterialFlatBottomBarItem {
  final Widget Function(bool isActive) iconBuilder;
  final Widget Function(bool isActive) titleBuilder;
  final Color Function(bool isActive) backgroundColor;

  const MaterialFlatBottomBarItem({
    @required this.iconBuilder,
    @required this.titleBuilder,
    @required this.backgroundColor,
  });
}
